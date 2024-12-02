//
//  LoginView.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 17/9/24.
//

import UIKit

// ´UIView´ for the LoginView
class LoginView: UIView {
    
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    var loginLabel = UILabel()
    var emailTextField: TextFieldView?
    var passwordTextField: TextFieldView?
    var topStackView = UIStackView()
    var mainStackView = UIStackView()
    var loginButton = UIButton()
    var spacerView = UIView()
    var largeSpacerView = UIView()
    var forgotPasswordButton = UIButton()
    var signupButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Style & Layout
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

// MARK: - Style & Layout

extension LoginView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false

        titleLabel = makeLabel(
            withText: "MoneyBox",
            font: UIFont.systemFont(ofSize: 40, weight: .heavy),
            alignment: .center,
            textColor: .mainColor
        )
        
        subtitleLabel = makeLabel(
            withText: "Save and Invest",
            font: UIFont.systemFont(ofSize: 16, weight: .regular),
            alignment: .center,
            textColor: .foggy
        )
        
        topStackView = makeStackView(
            withOrientation: .vertical,
            distribution: .fill,
            alignment: .fill,
            spacing: 0
        )
        
        loginLabel = makeLabel(
            withText: "Log in",
            font: UIFont.systemFont(ofSize: 22, weight: .heavy),
            alignment: .left,
            textColor: .black
        )
        
        emailTextField = TextFieldView(
            title: "Email",
            placeholder: "Email",
            keyboard: .default,
            delegate: self
        )

        passwordTextField = TextFieldView(
            title: "Password",
            placeholder: "Password",
            keyboard: .default,
            delegate: self
        )
        passwordTextField?.textField.isSecureTextEntry = true
        passwordTextField?.textField.enablePasswordToggle()
        
        loginButton = makeButton(
            withTitle: "Login",
            color: .mainColor
        )
        
        forgotPasswordButton = makeSecondaryButton(
            withTitle: "Forgot password",
            color: .clear,
            fontColor: .arches
        )
        
        signupButton = makeSecondaryButton(
            withTitle: "Don´t have an account? Sign up.",
            color: .clear,
            fontColor: .hof
        )
        
        mainStackView = makeStackView(
            withOrientation: .vertical,
            distribution: .fill,
            alignment: .fill,
            spacing: 15
        )
        
        spacerView = makeSpacerView(height: 10)
        largeSpacerView = makeSpacerView(height: 35)
    }
    
    func layout() {
        
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(subtitleLabel)
        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(largeSpacerView)
        mainStackView.addArrangedSubview(loginLabel)
        mainStackView.addArrangedSubview(spacerView)
        mainStackView.addArrangedSubview(emailTextField ?? UIView())
        mainStackView.addArrangedSubview(largeSpacerView)
        mainStackView.addArrangedSubview(passwordTextField ?? UIView())
        mainStackView.addArrangedSubview(largeSpacerView)
        mainStackView.addArrangedSubview(loginButton)
        mainStackView.addArrangedSubview(forgotPasswordButton)
        
        addSubview(mainStackView)
        addSubview(signupButton)
        
        mainStackView.centerYAnchor.constraint(
            equalTo: self.centerYAnchor
        ).isActive = true
        mainStackView.centerXAnchor.constraint(
            equalTo: self.centerXAnchor
        ).isActive = true
        
        mainStackView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        ).isActive = true
        
        mainStackView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        ).isActive = true
        mainStackView.bottomAnchor.constraint(
            equalTo: signupButton.topAnchor,
            constant: -40
        ).isActive = true
        
        
        signupButton.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        ).isActive = true
        signupButton.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        ).isActive = true
        signupButton.bottomAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.bottomAnchor
        ).isActive = true
    }
}

// MARK: - UITextFieldDelegate

extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField?.endEditing(true)
        passwordTextField?.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}

