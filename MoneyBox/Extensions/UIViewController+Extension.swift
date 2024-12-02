//
//  UIViewController+Extension.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 17/9/24.
//

import UIKit

// ´UIViewController´ for the ´UINavigationBarAppearance´ & ´UIAlertController´
extension UIViewController {
    
    func setStatusBarNew() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line also
        navBarAppearance.backgroundColor = .mainColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}

extension UIViewController {
    
    // Alert with styles
    public func showAlert(
        title: String,
        message: String,
        preferredStyle: UIAlertController.Style,
        actionTitle: String,
        actionStyle: UIAlertAction.Style
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )
        alert.addAction(
            UIAlertAction(
                title: actionTitle,
                style: actionStyle,
                handler: nil
            )
        )
        present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    // Simple alert
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
