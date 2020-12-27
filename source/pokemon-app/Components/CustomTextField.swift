//
//  CustomTextField.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 27/12/20.
//

import Foundation
import UIKit
class CustomTextField: UITextField {

    @IBInspectable var uiEdgeInsetsTop:CGFloat = 15
    @IBInspectable var uiEdgeInsetsLeft:CGFloat = 30
    @IBInspectable var uiEdgeInsetBottom:CGFloat = 15
    @IBInspectable var uiEdgeInsetsRight:CGFloat = 30
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = self.getUIEdgeInsets()
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = self.getUIEdgeInsets()
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = self.getUIEdgeInsets()
        return bounds.inset(by: padding)
    }
    
    private func getUIEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: self.uiEdgeInsetsTop, left: self.uiEdgeInsetsLeft, bottom: self.uiEdgeInsetBottom, right: self.uiEdgeInsetsRight)
    }
}
