//
//  LabelFactory.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 18/9/24.
//

import UIKit

// LabelFactory to build ´UILabel´
struct LabelFactory {
    
    static func build(
        text: String?,
        font: UIFont,
        backgroundColor: UIColor = .clear,
        textColor: UIColor?,
        textAlignment: NSTextAlignment = .center
    ) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }
}

