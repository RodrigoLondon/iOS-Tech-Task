//
//  LoginTests.swift
//  MoneyBoxTests
//
//  Created by Rodrigo Peña on 27/11/24.
//

import XCTest
import Networking
@testable import MoneyBox

final class LoginTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var dataProvider: DataProviderMock!

    override func setUp() {
        super.setUp()
        dataProvider = DataProviderMock()
        viewModel = LoginViewModel(dataProvider: dataProvider)
    }

    
    
    func testSuccessfulLogin() {
        // Use StubData.read to mock login response
        StubData.read(file: "LoginSucceed") { (result: Result<Networking.LoginResponse, Error>) in
            switch result {
            case .success(let response):
                Authentication.token = response.session.bearerToken
            case .failure(let error):
                XCTFail("Failed to mock login response: \(error.localizedDescription)")
            }
        }

        // Test LoginViewModel
        let expectation = self.expectation(description: "Successful login")
  
        dataProvider.login(request: DataProviderMock.mockLoginRequest) { result in
            guard let response = try? result.get() else {
                XCTFail("no response received from mocked data")
                return
            }
            XCTAssertEqual(Authentication.token, "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=")
            XCTAssertNotNil(response.user, "Unable to load user details from valid mocked data")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
