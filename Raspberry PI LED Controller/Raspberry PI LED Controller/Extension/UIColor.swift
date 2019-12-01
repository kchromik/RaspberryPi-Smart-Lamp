//
//  UIColor.swift
//  Raspberry PI LED Controller
//
//  Created by Kevin Chromik on 21.10.19.
//  Copyright © 2019 Kevin Chromik. All rights reserved.
//

import UIKit

extension UIColor {

    func rgbString() -> String {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: nil)

        return "\(Int(red*255)).\(Int(green*255)).\(Int(blue*255))"
    }
}
