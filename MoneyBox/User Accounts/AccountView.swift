//
//  AccountView.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 18/9/24.
//

import UIKit

// ´UIView´ for the AccountView
class AccountView: UIView {
    
    var accountNameLabel: UILabel = {
        LabelFactory.build(
            text: "",
            font: ThemeFont.semiBold(offSize: 15),
            textColor: .mainTealColor,
            textAlignment: .left
        )
    }()
    
    var referenceLabel: UILabel = {
        LabelFactory.build(
            text: "",
            font: ThemeFont.regular(offSize: 15),
            textColor: .foggy,
            textAlignment: .left
        )
    }()
    
    var amountLabel: UILabel = {
        LabelFactory.build(
            text: "",
            font: ThemeFont.regular(offSize: 15),
            textColor: .foggy,
            textAlignment: .left
        )
    }()
    
    var chevronImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buildSpacerView(height: 5),
            accountNameLabel,
            buildSpacerView(height: 10),
            amountLabel,
            buildSpacerView(height: 10),
            referenceLabel,
            buildSpacerView(height: 5)
        ])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Style & Layout

extension AccountView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addShadow(
            offSet: CGSize(width: 0, height: 3),
            color: .black,
            radius: 12.0,
            opacity: 0.1
        )
    }
    
    func layout() {
        addSubview(vStackView)
        addSubview(chevronImage)
        
        vStackView.topAnchor.constraint(
            equalTo: self.topAnchor,
            constant: 12
        ).isActive = true
        
        vStackView.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: -12
        ).isActive = true
        
        vStackView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: 12
        ).isActive = true
        
        vStackView.trailingAnchor.constraint(
            equalTo: chevronImage.leadingAnchor,
            constant: -12
        ).isActive = true
        
        chevronImage.centerYAnchor.constraint(
            equalTo: self.centerYAnchor
        ).isActive = true
        
        chevronImage.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: -12
        ).isActive = true
        
        chevronImage.heightAnchor.constraint(
            equalToConstant: 25
        ).isActive = true
        
        chevronImage.widthAnchor.constraint(
            equalToConstant: 20
        ).isActive = true
    }
}
