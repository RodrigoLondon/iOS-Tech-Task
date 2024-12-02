//
//  AppDelegate.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 15.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    var window: UIWindow? 
    let loginViewController = LoginViewController()
    lazy var loginNavigationController = UINavigationController(
        rootViewController: loginViewController
    )
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        setNavigationBarAppearance()
        registerForNotifications()
        loginNavigationController.isNavigationBarHidden = true
        setRootViewController(loginNavigationController)
        return true
    }
}

// MARK: - Set Root ViewController

extension AppDelegate {
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}

// MARK: - Set NavigationBarAppearance

extension AppDelegate {
    
    public func setNavigationBarAppearance() {
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().standardAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.mainColor,
            .font: UIFont.systemFont(
                ofSize: 35,
                weight: .heavy
            )
        ]
        UINavigationBar.appearance().standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.mainColor,
            .font: UIFont.systemFont(
                ofSize: 20,
                weight: .heavy
            )
        ]
    }
}

// MARK: - Set Root ViewController

extension AppDelegate: LogoutDelegate {
    @objc
    func didLogoutPressed() {
        didLogout()
    }
    
    func didLogout() {
        loginViewController.viewModel?.removeUserToken()
        setRootViewController(loginViewController)
    }
}

extension AppDelegate: LoginDelegate {
    
    func didLogin() {
         // Do something here once user has logged in.
        //  E.g: Notify is logged in and save login info
    }
}

extension AppDelegate {
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didLogoutPressed),
            name: .logout,
            object: nil
        )
    }
}
