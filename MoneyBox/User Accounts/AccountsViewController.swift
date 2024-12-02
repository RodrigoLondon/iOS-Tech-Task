//
//  AccountsViewController.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 18/9/24.
//

import UIKit
import Networking

// ´UIViewController´ for the AccountsViewController
class AccountsViewController: UIViewController {
    
    // The ViewModel for this screen
    private var viewModel: AccountsViewModel?
    let dataProvider = DataProvider()
    
    // Array to store the accounts products(fetched from the ViewModel)
    private var accountsProducts: [ProductResponse] = []
    private var accountsResponse: AccountResponse?
    
    var firstName: String?
    var lastName: String?
    var totalPlanValue: Double = 0.0
    
    // TableView
    var tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    lazy var logoutBarbuttonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(
                systemName: SFSymbols.logout
            ),
            style: .plain,
            target: self,
            action: #selector(logout)
        )
        button.tintColor = .mainColor
        return button
    }()
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "User Accounts"
        view.backgroundColor = .white
        
        
        // Initialize the ViewModel with the DataProvider
        viewModel = AccountsViewModel(dataProvider: dataProvider)
        
        // Setup ViewModel bindings &
        // TableView & headerView
        setupBindings()
        
        // Fetch accounts once the view loads
        viewModel?.fetchAccounts()
        
        // Setup Refresh Control
        setUpRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = logoutBarbuttonItem
    }
    
}

// MARK: - Functions

extension AccountsViewController {

    func setUpRefreshControl() {
        refreshControl.tintColor = .foggy
        refreshControl.addTarget(
            self,
            action: #selector(refreshContent),
            for: .valueChanged
        )
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshContent() {
        viewModel?.fetchAccounts()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func setupBindings() {
        // When the data is loaded, reload the table view
        viewModel?.onDataLoaded = { [weak self] in
            self?.accountsProducts = self?.viewModel?.accountsProducts ?? []
            self?.accountsResponse = self?.viewModel?.accountsResponse
           DispatchQueue.main.async {
               self?.tableView.reloadData()
               self?.totalPlanValue =  self?.accountsResponse?.totalPlanValue ?? 0.0
               self?.setup()
            }
        }
    }
    
    @objc
    func logout(sender: UIButton) {
        NotificationCenter.default.post(
            name: .logout,
            object: nil
        )
    }
}

// MARK: - Set up

extension AccountsViewController {
    
    private func setup() {
        setupTableView()
        setupTableHeaderView(
            name: "Hello \(firstName ?? "John") \(lastName ?? "Doe")",
            total: "Total Plan Value",
            amount: "£\(totalPlanValue)",
            tableView: tableView
        )
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(
            AccountCell.self,
            forCellReuseIdentifier: AccountCell.reuseID
        )
        tableView.rowHeight = AccountCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - TableView Data Source

extension AccountsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountsProducts.isEmpty else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AccountCell.reuseID,
            for: indexPath
        ) as? AccountCell else { return UITableViewCell() }

        
        guard let accountsResponse = accountsResponse?.productResponses else { return UITableViewCell() }
        
        let accounts = accountsResponse[indexPath.row]
        
        // Configure the cell with account data
        cell.accountView.accountNameLabel.text = accounts.product?.friendlyName
        cell.accountView.amountLabel.text = "Plan value: £\(accounts.planValue ?? 0.0)"
        cell.accountView.referenceLabel.text = "Moneybox: £\(accounts.moneybox ?? 0.0)"
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let accounts = accountsResponse?.productResponses else { return 0 }
        return accounts.count
    }
}

// MARK: - TableView Delegate

extension AccountsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let accountsResponse = accountsResponse else { return }
        let product = accountsProducts[indexPath.row]
        let vc = AccountDetailViewController(product: product, account: accountsResponse)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension TableHeaderView

extension UIViewController {
    
    func setupTableHeaderView(
        name: String,
        total: String,
        amount: String,
        tableView: UITableView
    ) {
        
        let header = HeaderView(frame: .zero)
        
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        header.nameLabel.text = name
        header.totalPlanLabel.text = total
        header.amountLabel.text = amount
        tableView.tableHeaderView = header
    }
}

