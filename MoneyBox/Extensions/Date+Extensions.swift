//
//  Date+Extensions.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 27/11/24.
//

import Foundation

// ´Date´ to check if token has expired
extension Date {
    // Check if 5 min have passed and token has expired
    func isTokenExpiredSinceDate(_ date: Date) -> Bool {
        timeIntervalSince(date) >= 300 // 60 seconds * 5 min = 300 seconds
    }
}
