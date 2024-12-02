//
//  AccountsTests.swift
//  MoneyBoxTests
//
//  Created by Rodrigo Peña on 27/11/24.
//

import XCTest
import Networking
@testable import MoneyBox

final class AccountsTests: XCTestCase {
        var viewModel: AccountsViewModel!
        var dataProvider: DataProviderMock!

        override func setUp() {
            super.setUp()
            dataProvider = DataProviderMock()
            viewModel = AccountsViewModel(dataProvider: dataProvider)
        }

        func testFetchAccountsSuccess() {
            // Mock a valid response in Accounts.json
            // Use StubData.read to mock Accounts response
            StubData.read(file: "Accounts") { (result: Result<Networking.AccountResponse, Error>) in
                switch result {
                case .success(let response):
                    self.viewModel.accountsProducts = response.productResponses!
                case .failure(let error):
                    XCTFail("Failed to mock Accounts response: \(error.localizedDescription)")
                }
            }

            let expectation = self.expectation(description: "Fetch accounts")
            
            dataProvider.fetchProducts { result in
                guard let response = try? result.get() else {
                    XCTFail("no response received from mocked data")
                    return
                }
                XCTAssertEqual(self.viewModel.accountsProducts.count, response.productResponses?.count)
                XCTAssertEqual(response.productResponses?.count, 2)
                XCTAssertEqual(self.viewModel.accountsProducts.count, 2)
                XCTAssertEqual(self.viewModel.accountsProducts[0].moneybox, 570.0)
                XCTAssertEqual(self.viewModel.accountsProducts[0].product?.name, "ISA")
                
                XCTAssertNotNil(self.viewModel.accountsProducts.first, "no accounts/products parsed succesfully")
                
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1, handler: nil)
        }

        func testFetchAccountsEmpty() {
            // Mock a valid response in Accounts.json
            // Mock an empty response in Accounts.json
            // Use StubData.read to mock Accounts response
            StubData.read(file: "Accounts") { (result: Result<Networking.AccountResponse, Error>) in
                switch result {
                case .success(let response):
                    self.viewModel.accountsProducts = response.productResponses!
                case .failure(let error):
                    XCTFail("Failed to mock Accounts response: \(error.localizedDescription)")
                }
            }

            let expectation = self.expectation(description: "Fetch empty accounts")
            
            dataProvider.fetchProducts { result in
                guard let response = try? result.get() else {
                    XCTFail("no response received from mocked data")
                    return
                }
                
                XCTAssertFalse(((response.productResponses?.isEmpty) == nil))
                XCTAssertFalse(self.viewModel.accountsProducts.isEmpty)
                
                expectation.fulfill()
            }
            waitForExpectations(timeout: 1, handler: nil)
        }
    }
