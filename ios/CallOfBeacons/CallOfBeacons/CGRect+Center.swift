//
//  CGRect+Center.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 04.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        get {
            return CGPoint(x: origin.x + (width / 2), y: origin.y + (height / 2))
        }
        set {
            origin.x = newValue.x - (width / 2)
            origin.y = newValue.y - (height / 2)
        }
    }
}

extension CGPoint {
    func pointFor(angle: CGFloat, withRadius radius: CGFloat) -> CGPoint {
        let x = cos(angle) * radius + self.x
        let y = sin(angle) * radius + self.y
        return CGPoint(x: x, y: y)
    }
}