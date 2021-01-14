//
//  InspectableExtensions.swift
//  YogaExplore
//
//  Created by Ankit Batra on 08/01/21.
//

import Foundation
import UIKit

public extension UIView {
    @IBInspectable var ibCornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var shadowOnTop: Bool {
        set {
            if newValue == true {
                addShadowOnTop()
            }
        }
        get {
            return self.layer.shadowOffset.height == -7
        }
    }
    @IBInspectable var shadowOnBottom: Bool {
        set {
            if newValue == true {
                addShadowOnBottom()
            }
        }
        get {
            return self.layer.shadowOffset.height == 7
        }
    }
}
