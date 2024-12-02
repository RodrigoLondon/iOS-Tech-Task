//
//  AccountDetailViewModel.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 23/9/24.
//

import Foundation
import Networking

// AccountDetailViewModel for the AccountDetailViewController
class AccountDetailViewModel {
    
    private let dataProvider: DataProvider
    var productResponse: ProductResponse
    
    // Closures to notify the ViewController when data changes
    var onAccountDataUpdated: (() -> Void)?
    var onPaymentSuccess: (() -> Void)?
    var onErrorOccurred: ((String) -> Void)?
    
    // Properties for product details
    var productName: String? {
        return productResponse.product?.friendlyName
    }
    
    var moneybox: String {
        return "Moneybox: £\(moneyBoxAmount ?? 0)"
    }
    
    var planValue: String? {
        return "Plan Value: £\(productResponse.planValue ?? 0.0)"
    }
    
    lazy var moneyBoxAmount = productResponse.moneybox
    
    // Initializer with account product and dataProvider
    init(dataProvider: DataProvider, product: ProductResponse) {
        self.dataProvider = dataProvider
        self.productResponse = product
        self.loadAccountDetails()
    }
    
    // Load initial account data and notify the ViewController
    func loadAccountDetails() {
        onAccountDataUpdated?()
    }
    
    func makeOneOffPayment() {
        guard let productId = productResponse.id else {
            onErrorOccurred?("Invalid account ID")
            return
        }
        
        let request = OneOffPaymentRequest(
            amount: 10,
            investorProductID: productId
        )
        dataProvider.addMoney(request: request) { [weak self] result in
            switch result {
            case .success(let updatedMoneybox):
                // Update the account's Moneybox and notify the ViewController
                self?.moneyBoxAmount = updatedMoneybox.moneybox
                self?.onPaymentSuccess?()
                self?.onAccountDataUpdated?()
            case .failure(let error):
                self?.onErrorOccurred?(error.localizedDescription)
            }
        }
    }
}
