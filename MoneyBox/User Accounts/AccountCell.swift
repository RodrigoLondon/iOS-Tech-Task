//
//  AccountCell.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 17/9/24.
//

import UIKit

// ´UITableViewCell´ for the AccountCell
class AccountCell: UITableViewCell {
    
    let accountView = AccountView()
    
    static let reuseID = "AccountCell"
    static let rowHeight: CGFloat = 150
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(accountView)
        
        accountView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 12
        ).isActive = true
        
        accountView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -12
        ).isActive = true
        
        accountView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 12
        ).isActive = true
        
        accountView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -12
        ).isActive = true
    }
}
