//
//  RGBColor.swift
//  Course - 1st swift apps - HW-02
//
//  Created by Lev Litvak on 14.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

struct RGBColor {
    var red: Float
    var green: Float
    var blue: Float
    var alpha: Float
    
    var components: [Float] {
        [red, green, blue, alpha]
    }
    
    mutating func setComponent(index: Int, value: Float) {
        switch index {
            case 0: red = value
            case 1: green = value
            case 2: blue = value
            case 3: alpha = value
            default: break
        }
    }
    
    init(red: Float, green: Float, blue: Float, alpha: Float) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}
