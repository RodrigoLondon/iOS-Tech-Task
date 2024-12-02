//
//  AccountDetailView.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 19/9/24.
//

import UIKit

// ´UIView´ for the AccountDetailView
class AccountDetailView: UIView {
    
    var mainStackView = UIStackView()
    let accountView = AccountView()
    var addButton = UIButton()
    let spacing: CGFloat = 20.0
    
    var buttonTapped: (() -> Void)?
    
    var owlImage: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(named: "moneyboxOwl")
        )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func addButtonTapped() {
        addMoney()
    }
    
    func addMoney() {
        self.buttonTapped?()
    }
}

// MARK: - Style & Layout

extension AccountDetailView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView = makeStackView(
            withOrientation: .vertical,
            distribution: .fill,
            alignment: .fill,
            spacing: spacing
        )
        
        addButton = makeButton(
                 withTitle: "Add £10",
                 color: .mainColor
             )
        
        accountView.accountNameLabel.text = "Product name"
        accountView.accountNameLabel.textAlignment = .center
    
        accountView.amountLabel.text = "Plan value: "
        accountView.amountLabel.textAlignment = .center
    
        accountView.referenceLabel.text = "Moneybox: "
        accountView.referenceLabel.textAlignment = .center
        
        accountView.chevronImage.isHidden = true
        
        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside
        )
    }
    
    func layout() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(
            makeSpacerView(height: spacing)
        )
        mainStackView.addArrangedSubview(owlImage)
        mainStackView.addArrangedSubview(accountView)
        mainStackView.addArrangedSubview(
            makeSpacerView(height: spacing)
        )
        mainStackView.addArrangedSubview(addButton)
        mainStackView.addArrangedSubview(
            makeSpacerView(height: spacing)
        )
        
        mainStackView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: spacing
        ).isActive = true
        
        mainStackView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -spacing
        ).isActive = true
        
        mainStackView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: spacing
        ).isActive = true
        
        mainStackView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -spacing
        ).isActive = true
    }
}
