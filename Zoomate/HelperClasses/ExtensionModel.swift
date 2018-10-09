//
//  ExtensionModel.swift
//  Kingle
//
//  Created by Koshal Saini on 20/07/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

@IBDesignable
class ExtensionModel: NSObject {}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get{
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = borderColor?.cgColor
        }
    }
}


// MARK:-
// MARK:- UIButton Extension
extension UIButton {
    func initilizationButtonBorder() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.3058823529, alpha: 1)
        self.clipsToBounds = true
    }
    
    func initilizationButtonBackgroundColor() {
        self.layer.cornerRadius = self.frame.height/2
        self.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.3058823529, alpha: 1)
        self.clipsToBounds = true
    }
    
    func initilizationRoundCornerButton() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}

// MARK:-
// MARK:- UITextField Extension
extension UITextField {
    func initilizationTextFieldBorder() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.3058823529, alpha: 1)
        self.clipsToBounds = true
    }
    
    func initilizationRoundCornerTextField() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}

// MARK:-
// MARK:- UITextField Extension
extension UIView {
    func initilizationViewBorder() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.3058823529, alpha: 1)
        self.clipsToBounds = true
    }
}


    extension UIView {
        func initilizationSliderViewBorder() {
            self.layer.borderWidth = 1
            self.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            self.clipsToBounds = true
        }
    
}

