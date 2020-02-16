//
//  ViewController.swift
//  Course - 1st swift apps - HW-06
//
//  Created by Lev Litvak on 31.01.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

protocol SetColorViewControllerDelegate {
    func changeViewBackgroundColor(color: RGBColor)
}

class SetColorViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var colorView: UIView!
    
    // 0 - red, 1 - green, 2 - blue
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: Private properties
    private let colors: [UIColor] = [.red, .green, .blue]
    
    // MARK: Public properties
    var previousText: String? // need to remember that, if user makes a mistake in textFields
    var rgbColor: RGBColor!
    var delegate: MainViewController!
    
    // MARK: Initializers
    func setupSliders() {
        for slider in sliders {
            slider.setup(minValue: 0,
                         maxValue: 1,
                         initialValue: rgbColor.components[slider.tag],
                         tintColor: colors[slider.tag])
        }
    }
    
    private func setupLabels() {
        for label in labels {
            label.text = rgbColor.components[label.tag].toText()
        }
    }
    
    private func setupTextFields() {
        for textField in textFields {
            textField.delegate = self
            textField.addDoneButtonOnKeyboard()
            textField.text = rgbColor.components[textField.tag].toText()
        }
    }
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        setupLabels()
        setupSliders()
        setupTextFields()
        
        updateBackgoundColorIn(view: colorView, with: rgbColor)
    }
    
    //MARK: IBActions
    @IBAction func sliderMoved(_ sender: UISlider) {
        labels[sender.tag].text = sender.value.toText()
        textFields[sender.tag].text = sender.value.toText()
        rgbColor.setComponent(index: sender.tag, value: sender.value)
        
        updateBackgoundColorIn(view: colorView, with: rgbColor)
    }
    
    @IBAction func doneButtonPressed() {
        delegate.changeViewBackgroundColor(color: rgbColor)
        dismiss(animated: true)
    }
}
