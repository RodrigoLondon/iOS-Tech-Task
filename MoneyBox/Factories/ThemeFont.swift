//
//  ThemeFont.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 18/9/24.
//

import UIKit

// ´UIFont´for the fonts used.
struct ThemeFont {
    
    static func regular(offSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(offSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
    
    static func semiBold(offSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-SemiBold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
    }
}
