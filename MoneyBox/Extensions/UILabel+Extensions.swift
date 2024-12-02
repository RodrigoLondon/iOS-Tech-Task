//
//  UILabel+Extensions.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 28/10/24.
//

import UIKit

// ´UILabel´ to hide and clear text
extension UILabel {
    
    func hideAndClear(){
        self.text = ""
        self.isHidden = true
    }
    
    func showWithMessage(message: String) {
        self.text = message
        self.isHidden = false
    }
}
