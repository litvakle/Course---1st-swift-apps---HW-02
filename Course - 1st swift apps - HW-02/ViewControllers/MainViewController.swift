//
//  MainViewController.swift
//  Course - 1st swift apps - HW-02
//
//  Created by Lev Litvak on 14.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Private properties
    var rgbColor = RGBColor(red: 1, green: 1, blue: 1, alpha: 1) // white color
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        updateBackgoundColorInView(view: view, rgbColor: rgbColor)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scvc = segue.destination as? SetColorViewController {
            scvc.rgbColor = rgbColor
            scvc.delegate = self
        }
    }
}

extension MainViewController: SetColorViewControllerDelegate {
    func changeViewBackgroundColor(rgbColor: RGBColor) {
        self.rgbColor = rgbColor
        updateBackgoundColorInView(view: view, rgbColor: rgbColor)
    }
}
