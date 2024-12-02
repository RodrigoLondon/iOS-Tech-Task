//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import Networking

protocol LoginDelegate: AnyObject {
    func didLogin()
}

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

// ´UIViewController´ for the LoginViewController
class LoginViewController: UIViewController {
    
    // Create an instance of the LoginViewModel
    var viewModel: LoginViewModel?
    
    let loginView = LoginView()
    let margin: CGFloat = 20
    
    // animation
    var leadingEdgeOffScreen: CGFloat = -1000
    var viewLeadingAnchor: NSLayoutConstraint?
    
    var scrollView = makeScrollView()
    
    weak var delegate: LoginDelegate?
    
    var email: String? {
        return loginView.emailTextField?.textField.text
    }
    
    var password: String? {
        return loginView.passwordTextField?.textField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the ViewModel
        let dataProvider = DataProvider()
        // Inject DataProvider or pass as dependency
        viewModel = LoginViewModel(dataProvider: dataProvider)
        
        // Setup UI bindings
        setupBindings()
        
        // Style & Layout
        style()
        layout()
        
        clearErrorLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideActivityIndicator()
    }
}

// MARK: - Extension - Style & Layout

extension LoginViewController {
    
    private func style() {
        view.backgroundColor = .white
        loginView.passwordTextField?.isSecureTextEntry = true
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        loginView.loginButton.addTarget(
            self,
            action: #selector(loginTapped),
            for: .touchUpInside
        )
        loginView.loginButton.alpha = 0
        
        loginView.forgotPasswordButton.addTarget(
            self,
            action: #selector(forgotPasswordTapped),
            for: .touchUpInside
        )
        
        loginView.signupButton.addTarget(
            self,
            action: #selector(signUpTapped),
            for: .touchUpInside
        )
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(loginView)
        
        
        scrollView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 0
        ).isActive = true
        
        scrollView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: 0
        ).isActive = true
        
        scrollView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor
        ).isActive = true
        
        scrollView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor
        ).isActive = true
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
        ])
        
        viewLeadingAnchor = loginView.leadingAnchor.constraint(
            equalTo: scrollView.leadingAnchor,
            constant: leadingEdgeOffScreen
        )
        viewLeadingAnchor?.isActive = true
    }
    
    func animateConstraints() {
        viewLeadingAnchor?.constant = margin
        
        loginView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -margin
        ).isActive = true
    }
}

// MARK: - Functions

extension LoginViewController {
    
    @objc
    func loginTapped() {
        login()
    }
    
    @objc
    func forgotPasswordTapped() {
        forgotPassword()
    }
    
    @objc
    func signUpTapped() {
        signUp()
    }
    
    private func login() {
        guard let email = email, let password = password else {
            assertionFailure("Error Login in ")
            return
        }
        
        if emailAndPasswordAreNotEmpty() {
            
            showActivityIndicator()
            delegate?.didLogin()
            
            // Email and password
            viewModel?.email = email
            viewModel?.password = password
            
            // Trigger the login process
            viewModel?.login()
            
            // Clear Error Label
            clearErrorLabel()
            
        } else {
            showActivityIndicator()
            // Clear TextFields
            clearTextFields()
        }
        
        hideActivityIndicator()
        showErrorMessage(withMessage: "Wrong")
        // Clear TextFields
        clearTextFields()
    }
    
    private func showActivityIndicator() {
        loginView.loginButton.configuration?.showsActivityIndicator = false
    }
    
    private func hideActivityIndicator() {
        loginView.loginButton.configuration?.showsActivityIndicator = false
    }
    
    private func clearTextFields() {
        loginView.emailTextField?.textField.text = ""
        loginView.passwordTextField?.textField.text = ""
    }
    
    private func clearErrorLabel() {
        loginView.emailTextField?.errorLabel.hideAndClear()
        loginView.passwordTextField?.errorLabel.hideAndClear()
    }
    
    private func forgotPassword() {
        // TODO: add reset password logic
        print("forgot password: add reset password logic")
        showAlert(
            title: "Reset Password",
            message: "Reset Password feature needs to be added",
            actionTitle: "OK"
        )
    }
    
    private func signUp() {
        // TODO: add sign up logic
        print("sign up: add sign up logic")
        showAlert(
            title: "Sign Up",
            message: "Sign Up feature needs to be added",
            actionTitle: "OK"
        )
    }
    
    private func emailAndPasswordAreNotEmpty() -> Bool {
        guard let email = email, let password = password else {
            assertionFailure("Error Login in ")
            return false
        }
        
        if !email.isEmpty && !password.isEmpty {
            return true
        }
        return false
    }
    
    private func setupBindings() {
          // Bind to isAuthenticated to react to the login result
          viewModel?.isAuthenticated = { [weak self] success in
              if success {
                  // If login succeeds, navigate to the next screen
                  self?.navigateToAccounts()
              } else {
                  // If login fails, show the error message
                  self?.showErrorMessage(withMessage: "Wrong: \(String(describing: self?.viewModel?.errorMessage))")
              }
          }
      }
    
    private func navigateToAccounts() {
        guard let viewModel = viewModel else { return }
        let accountsVC = AccountsViewController(
            firstName: viewModel.firstName,
            lastName: viewModel.lastName
        )
        navigationController?.pushViewController(accountsVC, animated: true)
    }
}

// MARK: - Error Message

extension LoginViewController {
    
    private func showErrorMessage(withMessage message: String) {
        guard let email = email, let password = password else {
            return
        }
        
        if email.isEmpty {
            loginView.emailTextField?.errorLabel.showWithMessage(message: "\(message) email")
            shakeButton()
        } else {
            loginView.emailTextField?.errorLabel.hideAndClear()
        }
        
        if password.isEmpty {
            loginView.passwordTextField?.errorLabel.showWithMessage(message: "\(message) password")
            shakeButton()
        } else {
            loginView.passwordTextField?.errorLabel.hideAndClear()
        }
    }
}

// MARK: - Animation

extension LoginViewController {
    
    private func animate() {
        let animator = UIViewPropertyAnimator(
            duration: 1.5,
            curve: .easeInOut
        ) {
            self.animateConstraints()
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
        
        let buttonAnimator = UIViewPropertyAnimator(
            duration: 1.25,
            curve: .easeInOut
        ) {
            self.loginView.loginButton.alpha = 1
            self.view.layoutIfNeeded()
        }
        buttonAnimator.startAnimation(afterDelay: 1)
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        loginView.loginButton.layer.add(
            animation,
            forKey: "shake"
        )
    }
}
