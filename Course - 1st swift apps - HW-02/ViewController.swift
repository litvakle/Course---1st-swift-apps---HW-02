//
//  ViewController.swift
//  Course - 1st swift apps - HW-02
//
//  Created by Lev Litvak on 31.01.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        setupSliders()
        
        updateColorView()
        updateLabels()
        updateTextFields()
    }

    @IBAction func SliderMoved() {
        updateColorView()
        updateLabels()
        updateTextFields()
    }
    
    func setupSliders() {
        redSlider.minimumValue = 0
        greenSlider.minimumValue = 0
        blueSlider.minimumValue = 0
        
        redSlider.maximumValue = 1
        greenSlider.maximumValue = 1
        blueSlider.maximumValue = 1
        
        redSlider.value = 0.5
        greenSlider.value = 0.5
        blueSlider.value = 0.5
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        blueSlider.tintColor = .blue
    }
    
    func updateLabels() {
        if redLabel.text != redSlider.value.toText() {
            redLabel.text = redSlider.value.toText()
        }
        
        if greenLabel.text != greenSlider.value.toText() {
            greenLabel.text = greenSlider.value.toText()
        }
        
        if blueLabel.text != blueSlider.value.toText() {
            blueLabel.text = blueSlider.value.toText()
        }
    }
    
    func updateTextFields() {
        if redTextField.text! != redSlider.value.toText() {
            redTextField.text = redSlider.value.toText()
        }
        
        if greenTextField.text! != greenSlider.value.toText() {
            greenTextField.text = greenSlider.value.toText()
        }
        
        if blueTextField.text! != blueSlider.value.toText() {
            blueTextField.text = blueSlider.value.toText()
        }
    }
    
    func updateColorView() {
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
}

//MARK: Extensions
extension Float {
    func toText() -> String {
        return String(format: "%.2f", self)
    }
}
