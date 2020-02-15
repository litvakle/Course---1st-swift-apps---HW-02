//
//  ViewController.swift
//  Course - 1st swift apps - HW-06
//
//  Created by Lev Litvak on 31.01.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class SetColorViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var colorView: UIView!
    
    // 0 - red, 1 - green, 2 - blue
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: Private properties
    private let colors: [UIColor] = [.red, .green, .blue]
    var previousText: String? // need to remember that, if user makes a mistake in textFields
    var rgbColor: RGBColor!
    var delegate: MainViewController!
    
    // MARK: Initializers
    func setupSliders() {
        sliders.forEach {
            $0.setup(minValue: 0,
                     maxValue: 1,
                     initialValue: rgbColor.components[$0.tag],
                     tintColor: colors[$0.tag])
        }
    }
    
    private func setupLabels() {
        labels.forEach { $0.text = rgbColor.components[$0.tag].toText() }
    }
    
    private func setupTextFields() {
        textFields.forEach { $0.delegate = self }
        textFields.forEach { $0.addDoneButtonOnKeyboard() }
        
        textFields.forEach { $0.text = rgbColor.components[$0.tag].toText() }
    }
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        setupLabels()
        setupSliders()
        setupTextFields()
        
        updateBackgoundColorInView(view: colorView, rgbColor: rgbColor)
    }
    
    //MARK: IBActions
    @IBAction func sliderMoved(_ sender: UISlider) {
        labels[sender.tag].text = sender.value.toText()
        textFields[sender.tag].text = sender.value.toText()
        rgbColor.setComponent(index: sender.tag, value: sender.value)
        
        updateBackgoundColorInView(view: colorView, rgbColor: rgbColor)
    }
    
    @IBAction func doneButtonPressed() {
        delegate.rgbColor = rgbColor
        delegate.updateColor()
        dismiss(animated: true)
    }
}
