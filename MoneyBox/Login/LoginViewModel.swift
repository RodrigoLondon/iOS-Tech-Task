//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 17/9/24.
//

import UIKit
import Networking

class LoginViewModel {
    
    // Bearer token from the login response
    var bearerToken = ""
    
    // Create a SessionManager instance
    var sessionManager = SessionManager()

    var email: String = ""
    var password: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var errorMessage: String? = nil
    var isAuthenticated: ((Bool) -> Void)?
    
    // ´Date´ to keep track the time when
    //the user logged in for the token refresh
    private var loginTimestamp: Date?
    
    private let dataProvider: DataProviderLogic
    
    init(dataProvider: DataProviderLogic = DataProvider()) {
        self.dataProvider = dataProvider
    }
    
    func login() {
        let loginRequest = LoginRequest(email: email, password: password)
        dataProvider.login(request: loginRequest) { [weak self] result in
            switch result {
            case .success(let response):
                // Store the login date for refreshing the token
                self?.loginTimestamp = Date()
                
                self?.firstName = response.user.firstName ?? ""
                self?.lastName = response.user.lastName ?? ""
                
                // Store the bearer token for future use
                self?.sessionManager.setUserToken(response.session.bearerToken)
                self?.bearerToken = response.session.bearerToken
                self?.isAuthenticated?(true)
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.isAuthenticated?(false)
            }
        }
    }
    
    func removeUserToken() {
        loginTimestamp = nil
        sessionManager.removeUserToken()
    }
}
    
    
