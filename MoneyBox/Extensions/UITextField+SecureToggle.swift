//
//  UITextField+SecureToggle.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 17/9/24.
//

import UIKit

let passwordToggleButton = UIButton(type: .custom)

// ´UITextField´ for the Password Toggle
extension UITextField {
    
    func enablePasswordToggle() {
        passwordToggleButton.setImage(
            UIImage(systemName: SFSymbols.eyeSlash),
            for: .normal
        )
        passwordToggleButton.setImage(
            UIImage(systemName: SFSymbols.eye),
            for: .selected
        )
        passwordToggleButton.addTarget(
            self,
            action: #selector(togglePassword),
            for: .touchUpInside
        )
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc
    func togglePassword(_ sender: Any) {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
