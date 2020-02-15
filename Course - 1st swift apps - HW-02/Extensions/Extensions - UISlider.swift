//
//  Extensions - UISlider.swift
//  Course - 1st swift apps - HW-02
//
//  Created by Lev Litvak on 15.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

extension UISlider {
    func setup(minValue: Float, maxValue: Float, initialValue: Float, tintColor: UIColor) {
        self.minimumValue = minValue
        self.maximumValue = maxValue
        self.value = initialValue
        self.tintColor = tintColor
    }
}
