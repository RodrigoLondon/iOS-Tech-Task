//
//  AccountsViewModel.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 18/9/24.
//

import Foundation
import Networking

// AccountsViewModel for the AccountsViewController
class AccountsViewModel {
    var accountsResponse: AccountResponse?
    var accountsProducts: [ProductResponse] = []
    var accounts: [Account] = []
    var onDataLoaded: (() -> Void)?
    
    private let dataProvider: DataProviderLogic
    
    init(dataProvider: DataProviderLogic = DataProvider()) {
        self.dataProvider = dataProvider
    }
    
    func fetchAccounts() {
        dataProvider.fetchProducts { [weak self] result in
            switch result {
            case .success(let accountResponse):
                self?.accountsProducts = accountResponse.productResponses ?? []
                self?.accountsResponse = accountResponse
                self?.accounts = accountResponse.accounts ?? []
                self?.onDataLoaded?()
            case .failure(let error):
                print("Error fetching accounts: \(error.localizedDescription)")
            }
        }
    }
}
