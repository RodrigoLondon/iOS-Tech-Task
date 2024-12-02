//
//  TokenTests.swift
//  MoneyBoxTests
//
//  Created by Rodrigo Peña on 27/11/24.
//

import XCTest
@testable import MoneyBox

final class TokenTests: XCTestCase {

    func testTokenHasExpired() {
        let date = Date(timeInterval: -300, since: Date())
        XCTAssertTrue(Date().isTokenExpiredSinceDate(date), "Five minutes have passed and token has expired")
    }
    
    func testTokenHasNotExpired() {
        let date = Date(timeInterval: -5, since: Date())
        XCTAssertFalse(Date().isTokenExpiredSinceDate(date), "Five minutes have not passed yet and token has not expired")
    }
}
