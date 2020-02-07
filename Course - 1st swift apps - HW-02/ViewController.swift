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
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: Private properties
    private var previousText: String? // need to remember that, if user makes a mistake in textFields
    private var rgbColor: [Float] = [0.5, 0.5, 0.5, 1]
    private let colors: [UIColor] = [.red, .green, .blue]
    
    // MARK: Initializers
    func setupSliders() {
        sliders.forEach {
            $0.setup(minValue: 0,
                     maxValue: 1,
                     initialValue: rgbColor[$0.tag],
                     tintColor: colors[$0.tag])
        }
    }
    
    private func setupTextFields() {
        textFields.forEach { $0.delegate = self }
        textFields.forEach { $0.addDoneButtonOnKeyboard() }
    }
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        setupSliders()
        setupTextFields()
        
        updateColorView()
        labels.forEach { $0.text = rgbColor[$0.tag].toText() }
        textFields.forEach { $0.text = rgbColor[$0.tag].toText() }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // hide keyboard after touch view
        view.endEditing(true)
    }
    
    //MARK: IBActions
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        labels[sender.tag].text = sender.value.toText()
        textFields[sender.tag].text = sender.value.toText()
        
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
        
        let index = textField.tag
        labels[index].text = value.toText()
        sliders[index].value = value
        rgbColor[index] = value
        updateColorView()
    }
    
    private func updateColorView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(rgbColor[0]),
            green: CGFloat(rgbColor[1]),
            blue: CGFloat(rgbColor[2]),
            alpha: CGFloat(rgbColor[3])
        )
    }
}

// MARK: Float
extension Float {
    func toText() -> String {
        return String(format: "%.2f", self)
    }
}

// MARK: ViewController
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

// MARK: UITextField
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

// MARK: UISlider
extension UISlider {
    func setup(minValue: Float, maxValue: Float, initialValue: Float, tintColor: UIColor) {
        self.minimumValue = minValue
        self.maximumValue = maxValue
        self.value = initialValue
        self.tintColor = tintColor
    }
}
