//
//  AccountDetailViewController.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 17/9/24.
//

import UIKit
import Networking

// ´UIViewController´ for the AccountDetailViewController
class AccountDetailViewController: UIViewController {
    
    let product: ProductResponse
    let account: AccountResponse
    lazy var accountDetailView = AccountDetailView()
    lazy var scrollView = makeScrollView()
    let margin = 20.0
    
    // The Account ViewModel
    private var viewModel: AccountDetailViewModel?
    
    init(product: ProductResponse, account: AccountResponse) {
        self.product = product
        self.account = account
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        style()
        
        // Initialize the ViewModel with the account and a DataProvider instance
        let dataProvider = DataProvider() // Inject your DataProvider
        viewModel = AccountDetailViewModel(
            dataProvider: dataProvider,
            product:  product
        )
        
        // Bind ViewModel data to the UI
        setupBindings()
        
        // Load the initial account details
        viewModel?.loadAccountDetails()
        
        addMoney()
        
        DispatchQueue.main.async {
            // Update UI on the main thread after the task completes
            self.updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = false
    }
}

// MARK: - Style & Layout

extension AccountDetailViewController {
    
    func style() {
        title = "Individual Account"
        view.backgroundColor = .white
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(accountDetailView)
        
        scrollView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 0
        ).isActive = true
        
        scrollView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: 0
        ).isActive = true
        
        scrollView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 0
        ).isActive = true
        
        scrollView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: 0
        ).isActive = true
        
        accountDetailView.topAnchor.constraint(
            equalTo: scrollView.topAnchor,
            constant: 0
        ).isActive = true
        
        accountDetailView.bottomAnchor.constraint(
            equalTo: scrollView.bottomAnchor,
            constant: -margin
        ).isActive = true
        
        accountDetailView.leadingAnchor.constraint(
            equalTo: scrollView.leadingAnchor,
            constant: margin
        ).isActive = true
        
        accountDetailView.trailingAnchor.constraint(
            equalTo: scrollView.trailingAnchor,
            constant: margin
        ).isActive = true
    }
}


// MARK: - Functions

extension AccountDetailViewController {
    
    func addMoney() {
        accountDetailView.buttonTapped = { [weak self] in
            self?.viewModel?.makeOneOffPayment()
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        self.setupBindings()
    }
    
    @objc
    private func handleTokenRefreshed() {
        // Retry add money logic here
        addMoney()
    }
    
}

// MARK: - AccountDetailViewController & Bindings

extension AccountDetailViewController {
    // Bind ViewModel properties and actions to the UI
    private func setupBindings() {
        // Update UI when account data is updated
        viewModel?.onAccountDataUpdated = { [weak self] in
            self?.accountDetailView.accountView.accountNameLabel.text = self?.viewModel?.productName
            self?.accountDetailView.accountView.amountLabel.text = self?.viewModel?.planValue
            self?.accountDetailView.accountView.referenceLabel.text = self?.viewModel?.moneybox
        }
        
        // Handle payment success
        viewModel?.onPaymentSuccess = { [weak self] in
            self?.showAlert(
                title: "Success",
                message: "£10 has been added to your Moneybox!",
                actionTitle: "OK"
            )
        }
        
        // Handle errors
        viewModel?.onErrorOccurred = { [weak self] errorMessage in
            self?.showAlert(
                title: "Error",
                message: errorMessage.debugDescription,
                actionTitle: "OK"
            )
        }
    }
}
