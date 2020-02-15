//
//  Extensions - UIViewController.swift
//  Course - 1st swift apps - HW-02
//
//  Created by Lev Litvak on 15.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

// MARK: Extenstion ViewController
extension UIViewController{
    func showAlertByTextField(title: String, message: String, textField: UITextField, previousText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            textField.text = previousText
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func updateBackgoundColorInView(view: UIView, rgbColor: RGBColor) {
        view.backgroundColor = UIColor(
            red: CGFloat(rgbColor.red),
            green: CGFloat(rgbColor.green),
            blue: CGFloat(rgbColor.blue),
            alpha: CGFloat(rgbColor.alpha))
    }
}
