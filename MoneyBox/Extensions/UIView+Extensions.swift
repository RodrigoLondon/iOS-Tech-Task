//
//  UIView+Extensions.swift
//  MoneyBox
//
//  Created by Rodrigo Peña on 18/9/24.
//

import UIKit

// ´UIView´ extensions
extension UIView {
    
    func addShadow(
        offSet: CGSize,
        color: UIColor,
        radius: CGFloat,
        opacity: Float
    ) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offSet
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    
    func addCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
    }
    
    func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
    
    func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
    func buildSpacerView(width: CGFloat) -> UIView {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
        return view
    }
}
