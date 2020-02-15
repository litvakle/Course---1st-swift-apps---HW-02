//
//  Extensions - SetColorViewController.swift
//  Course - 1st swift apps - HW-02
//
//  Created by Lev Litvak on 15.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

extension SetColorViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // remembering text before edititng textField
        previousText = textField.text
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let value = Float(text), value <= 1 else {
            showAlertByTextField(title: "Error",
                                 message: "Value should be in interval [0;1]",
                                 textField: textField,
                                 previousText: previousText ?? "")
            return
        }
        
        let index = textField.tag
        labels[index].text = value.toText()
        sliders[index].value = value
        rgbColor.setComponent(index: index, value: value)
        updateBackgoundColorInView(view: colorView, rgbColor: rgbColor)
    }
}
