//
//  UITextField+.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/07/29.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

extension UIView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = CGColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
    }
}
