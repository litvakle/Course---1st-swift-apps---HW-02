//
//  ViewController.swift
//  Course - 1st swift apps - HW-02
//
//  Created by Lev Litvak on 31.01.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    // MARK: Private properties
    private var previousText: String? // need to remember that, if user makes a mistake in textFields
    private var rgbColor: (red: Float, green: Float, blue: Float) = (0.5, 0.5, 0.5)
    
    // MARK: Lifestyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        setupSliders()
        setupTextFields()
        
        updateColorView()
        updateLabels()
        updateTextFields()
    }
    
    // MARK: Initializers
    func setupSliders() {
        redSlider.setup(minValue: 0, maxValue: 1, initialValue: rgbColor.red, tintColor: .red)
        greenSlider.setup(minValue: 0, maxValue: 1, initialValue: rgbColor.green, tintColor: .green)
        blueSlider.setup(minValue: 0, maxValue: 1, initialValue: rgbColor.blue, tintColor: .blue)
    }
    
    private func setupTextFields() {
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        redTextField.addDoneButtonOnKeyboard()
        greenTextField.addDoneButtonOnKeyboard()
        blueTextField.addDoneButtonOnKeyboard()
    }
    
    // MARK: Override methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // hide keyboard after touch view
        view.endEditing(true)
    }
    
    //MARK: IBActions
    @IBAction func SliderMoved() {
        rgbColor.red = redSlider.value
        rgbColor.green = greenSlider.value
        rgbColor.blue = blueSlider.value
        
        updateLabels()
        updateTextFields()
        updateColorView()
    }
    
    // MARK: Private (and internal) methods
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // remembering text before edititng textField
        previousText = textField.text
        return true
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let value = Float(text), value <= 1 else {
            showAlertByTextField(title: "Error", message: "Value should be in interval [0;1]", textField: textField)
            return
        }
        
        textField.text = value.toText()
        rgbColor.red = Float(redTextField.text!)!
        rgbColor.green = Float(greenTextField.text!)!
        rgbColor.blue = Float(blueTextField.text!)!
        
        updateSliders()
        updateLabels()
        updateColorView()
    }
    
    private func updateLabelText(label: UILabel, newText: String) {
        if label.text != newText {
            label.text = newText
        }
    }
    
    private func updateLabels() {
        updateLabelText(label: redLabel, newText: rgbColor.red.toText())
        updateLabelText(label: greenLabel, newText: rgbColor.green.toText())
        updateLabelText(label: blueLabel, newText: rgbColor.blue.toText())
    }
    
    private func updateTextFieldText(textField: UITextField, newText: String) {
        if textField.text != newText {
            textField.text = newText
        }
    }
    
    private func updateTextFields() {
        updateTextFieldText(textField: redTextField, newText: rgbColor.red.toText())
        updateTextFieldText(textField: greenTextField, newText: rgbColor.green.toText())
        updateTextFieldText(textField: blueTextField, newText: rgbColor.blue.toText())
    }
    
    private func updateSliderValue(slider: UISlider, newValue: Float) {
        if slider.value != newValue {
            slider.value = newValue
        }
    }
    
    private func updateSliders() {
        updateSliderValue(slider: redSlider, newValue: rgbColor.red)
        updateSliderValue(slider: greenSlider, newValue: rgbColor.green)
        updateSliderValue(slider: blueSlider, newValue: rgbColor.blue)
    }
    
    private func updateColorView() {
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(rgbColor.red), green: CGFloat(rgbColor.green), blue: CGFloat(rgbColor.blue), alpha: 1)
    }
}

// MARK: Extensions
extension Float {
    func toText() -> String {
        return String(format: "%.2f", self)
    }
}

extension ViewController {
    func showAlertByTextField(title: String, message: String, textField: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            textField.text = self.previousText
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension UITextField {
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}

extension UISlider {
    func setup(minValue: Float, maxValue: Float, initialValue: Float, tintColor: UIColor) {
        self.minimumValue = minValue
        self.maximumValue = maxValue
        self.value = initialValue
        self.tintColor = tintColor
    }
}
