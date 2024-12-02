//
//  DataProviderMock.swift
//  MoneyBoxTests
//
//  Created by Rodrigo Peña on 27/11/24.
//

import Foundation
import Networking

// ´DataProviderLogic´ for the DataProviderMock for testing
class DataProviderMock: DataProviderLogic {
    
    static let mockLoginRequest = LoginRequest(
        email: "test+ios@moneyboxapp.com",
        password: "P455word12"
    )
    
    func login(request: Networking.LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        StubData.read(file: "LoginSucceed", callback: completion)
    }
    
    func fetchProducts(completion: @escaping ((Result<Networking.AccountResponse, Error>) -> Void)) {
        StubData.read(file: "Accounts", callback: completion)
    }

    func addMoney(request: Networking.OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
    }
}
