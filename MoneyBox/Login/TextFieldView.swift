//
//  TextFieldView.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 17/9/24.
//

import UIKit

class TextFieldView: UIView {
    
    var title: String
    var placeholder: String
    var keyboard: UIKeyboardType
    var delegate: UITextFieldDelegate
    var label = UILabel()
    var textField = UITextField()
    var stackView = UIStackView()
    var labelStackView = UIStackView()
    var isSecureTextEntry: Bool?
    var errorLabel = UILabel()
    
    lazy var textFieldFrame = CGRect(
        x: self.frame.size.width*0.10,
        y: self.frame.size.height*0.05,
        width: self.frame.size.width*0.80,
        height: self.frame.size.width*0.05)
    
    init(
        title: String,
        placeholder: String,
        keyboard: UIKeyboardType,
        delegate: UITextFieldDelegate
    ) {
        self.title = title
        self.placeholder = placeholder
        self.keyboard = keyboard
        self.delegate = delegate
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Style & Layout

extension TextFieldView {
    
    func style() {
        
        let frame =  CGRect(
            x: textField.frame.origin.x,
            y: textField.frame.origin.y,
            width: textField.frame.size.width,
            height: textField.frame.size.height*2
        )
        
        label = makeLabel(
            withText: title,
            font: UIFont.systemFont(ofSize: 16, weight: .regular),
            alignment: .left,
            textColor: .darkGray
        )
        
        textField = makeTextField(
            withPlaceholder: placeholder,
            keyboard: keyboard,
            delegate: delegate,
            frame: frame,
            isSecureTextEntry: isSecureTextEntry ?? false
        )
        
        errorLabel = makeLabel(
            withText: "",
            font: .systemFont(ofSize: 12, weight: .light),
            alignment: .left,
            textColor: UIColor.red
        )
        
        labelStackView = makeStackView(
            withOrientation: .horizontal,
            distribution: .equalSpacing,
            alignment: .fill,
            spacing: 20
        )
        
        stackView = makeStackView(
            withOrientation: .vertical,
            distribution: .fill,
            alignment: .fill,
            spacing: 12
        )
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        labelStackView.addArrangedSubview(label)
        labelStackView.addArrangedSubview(errorLabel)
        
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(textField)
        addSubview(stackView)
        
        stackView.topAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.topAnchor
        ).isActive = true
        
        stackView.bottomAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.bottomAnchor
        ).isActive = true
        
        stackView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        ).isActive = true
        
        stackView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        ).isActive = true
    }
}
