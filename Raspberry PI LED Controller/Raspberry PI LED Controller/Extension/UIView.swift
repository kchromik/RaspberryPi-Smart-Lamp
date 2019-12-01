//
//  UIView.swift
//  Raspberry PI LED Controller
//
//  Created by Kevin Chromik on 24.10.19.
//  Copyright © 2019 Kevin Chromik. All rights reserved.
//

import UIKit

extension UIView {

    func roundCorners(to radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
