//
//  RGBColor.swift
//  Course - 1st swift apps - HW-02
//
//  Created by Lev Litvak on 14.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

struct RGBColor {
    var red: Float = 0.5
    var green: Float = 0.5
    var blue: Float = 0.5
    var alpha: Float = 1
    
    var arrRGBColor: [Float] {
        [red, green, blue, alpha]
    }
    
    mutating func setColor(index: Int, value: Float) {
        switch index {
            case 0: red = value
            case 1: green = value
            case 2: blue = value
            case 3: alpha = value
            default: break
        }
    }
}
