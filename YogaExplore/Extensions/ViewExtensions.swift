//
//  ViewExtensions.swift
//  YogaExplore
//
//  Created by Ankit Batra on 08/01/21.
//

import Foundation
import UIKit

public extension UIView {

    func addShadowWithProperties(cornerRadius: CGFloat = 0, color: CGColor = UIColor.black.cgColor, opacity: Float = 0.5, offset: CGSize = .zero, radius: CGFloat = 5) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addShadowOnTop() {
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 0, height: -7)
        self.layer.shadowOpacity = 0.15
    }
    
    func addShadowOnBottom() {
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 0, height: 7)
        self.layer.shadowOpacity = 0.15
    }
}
