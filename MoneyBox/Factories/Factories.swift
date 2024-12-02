//
//  Factories.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 17/9/24.
//

import UIKit

// Factories for ´UIButton´ ´UITextField´ ´UIStackView´
// ´UIScrollView´ ´UIView´ spacerViews
public func makeTextField(
    withPlaceholder placeholder: String,
    keyboard: UIKeyboardType,
    delegate: UITextFieldDelegate,
    frame: CGRect,
    isSecureTextEntry: Bool
) -> UITextField {
    let textField = UITextField.init(frame: frame)
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = placeholder
    textField.keyboardType = keyboard
    textField.delegate = delegate
    textField.borderStyle = .roundedRect
    textField.isSecureTextEntry = isSecureTextEntry
    return textField
}

public func makeLabel(
    withText text: String,
    font: UIFont,
    alignment: NSTextAlignment,
    textColor: UIColor
) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = font
    label.numberOfLines = 0
    label.textAlignment  = alignment
    label.backgroundColor = .clear
    label.textColor = textColor
    label.adjustsFontForContentSizeCategory = true
    return label
}

public func makeButton(
    withTitle title: String,
    color: UIColor
) -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false

    var config = UIButton.Configuration.filled()
    config.baseBackgroundColor = color
    config.imagePadding = 10
    config.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 10, bottom: 18, trailing: 10)
    button.configuration?.titleLineBreakMode = .byWordWrapping
    button.configuration?.titleAlignment = .center
    button.configuration = config
    
    let attributedText = NSMutableAttributedString(string: title, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.kern: 1
    ])
    button.setAttributedTitle(attributedText, for: .normal) // Note how not button.setTitle()
    return button
}


public func makeSecondaryButton(
    withTitle title: String,
    color: UIColor,
    fontColor: UIColor
) -> UIButton {
    let button =  UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    var config = UIButton.Configuration.borderless()
    config.baseBackgroundColor = color
    config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
    button.configuration?.titleLineBreakMode = .byWordWrapping
    button.configuration?.titleAlignment = .center
    button.configuration = config
    
    let attributedText = NSMutableAttributedString(string: title, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
        NSAttributedString.Key.foregroundColor: fontColor,
        NSAttributedString.Key.kern: 0.8
    ])
    button.setAttributedTitle(attributedText, for: .normal) // Note how not button.setTitle()
    return button
}

public func makeCloseButton() -> UIButton {
    let button =  UIButton(type: .close)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
}

public func makeStackView(
    withOrientation axis: NSLayoutConstraint.Axis,
    distribution: UIStackView.Distribution,
    alignment: UIStackView.Alignment,
    spacing: CGFloat
) -> UIStackView {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = axis
    stackView.distribution = distribution
    stackView.alignment = alignment
    stackView.spacing = spacing
    return stackView
}

public func makeScrollView() -> UIScrollView {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    
    return scrollView
}

public func makeSpacerView(
    height: CGFloat? = nil
) -> UIView {
    let spacerView = UIView(frame: .zero)
    if let height = height {
        spacerView.heightAnchor.constraint(equalToConstant: height).setActiveBreakable()
    }
    spacerView.translatesAutoresizingMaskIntoConstraints = false
    return spacerView
}

public func makeHorizontalSpacerView(
    width: CGFloat? = nil
) -> UIView {
    let spacerView = UIView(frame: .zero)
    if let width = width {
        spacerView.widthAnchor.constraint(equalToConstant: width).setActiveBreakable()
    }
    spacerView.translatesAutoresizingMaskIntoConstraints = false
    return spacerView
}

public func makeImageView(named: String) -> UIImageView {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    view.image = UIImage(named: named)
    
    // By making the image hug itself a little bit less and less resistant to being compressed
    // we allow the image to stretch and grow as required
    view.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
    view.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)
    
    return view
}

public extension NSLayoutConstraint {
    @objc func setActiveBreakable(
        priority: UILayoutPriority = UILayoutPriority(900)
    ) {
        self.priority = priority
        isActive = true
    }
}

