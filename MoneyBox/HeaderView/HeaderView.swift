//
//  HeaderView.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 17/9/24.
//

import UIKit

// ´UIView´ for the HeaderView
class HeaderView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    lazy var nameLabel = UILabel()
    lazy var totalPlanLabel = UILabel()
    lazy var amountLabel = UILabel()
    lazy var stackView = UIStackView()
    let margin = 20.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 120)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: HeaderView.self)
        bundle.loadNibNamed("HeaderView", owner: self, options: nil)
        
        nameLabel = makeLabel(
            withText: nameLabel.text ?? "Hello John Doe",
            font: .monospacedSystemFont(ofSize: 18, weight: .bold),
            alignment: .center,
            textColor: .mainTealColor
        )
        
        totalPlanLabel = makeLabel(
            withText: totalPlanLabel.text ?? "Total Plan Value",
            font: .monospacedSystemFont(ofSize: 18, weight: .bold),
            alignment: .center,
            textColor: .mainTealColor
        )
        
        amountLabel = makeLabel(
            withText: amountLabel.text ?? "0.0",
            font: .monospacedSystemFont(ofSize: 28, weight: .bold),
            alignment: .center,
            textColor: .mainTealColor
        )
        
        stackView = makeStackView(
            withOrientation: .vertical,
            distribution: .fill,
            alignment: .fill,
            spacing: 0
        )
        
        stackView.addArrangedSubview(buildSpacerView(height: 10))
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(totalPlanLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(buildSpacerView(height: 10))
        
        contentView.addSubview(stackView)
        addSubview(contentView)
        
        contentView.backgroundColor = .white
            
        stackView.topAnchor.constraint(
            equalTo: contentView.safeAreaLayoutGuide.topAnchor,
            constant: 0
        ).isActive = true
        stackView.bottomAnchor.constraint(
            equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
            constant: 0
        ).isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: margin
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -margin
        ).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
