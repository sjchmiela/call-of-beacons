//
//  COBGridView.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 04.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class COBGridView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        (backgroundColor ?? UIColor.whiteColor()).setFill()
        CGContextFillRect(context, rect)
        for i in (1...Int(bounds.size.height / 10)).reverse() {
            switch (i + 9) % 10 {
            case 0:
                UIColor(red:0.25, green:0.32, blue:0.36, alpha:1.00).set()
            case 5:
                UIColor(red:0.25, green:0.32, blue:0.36, alpha:0.50).set()
            default:
                UIColor(red:0.25, green:0.32, blue:0.36, alpha:0.25).set()
            }
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 0, y: bounds.size.height - CGFloat(i) * 10 - 0.5))
            path.addLineToPoint(CGPoint(x: bounds.size.width, y: bounds.size.height - CGFloat(i) * 10 - 0.5))
            path.stroke()
        }
        
        let xCenter = bounds.size.width / 2
        let xCenterIndex = Int(bounds.size.width / 2)
        let xOffset = xCenter - CGFloat(xCenterIndex)
        
        for i in 1...Int(bounds.size.width / 10) {
            switch abs(i - (xCenterIndex / 10)) % 10 {
            case 0:
                UIColor(red:0.25, green:0.32, blue:0.36, alpha:1.00).set()
            case 5:
                UIColor(red:0.25, green:0.32, blue:0.36, alpha:0.50).set()
            default:
                UIColor(red:0.25, green:0.32, blue:0.36, alpha:0.15).set()
            }
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: CGFloat(i) * 10 + xOffset + 1, y: 0))
            path.addLineToPoint(CGPoint(x: CGFloat(i) * 10 + xOffset + 1, y: bounds.size.height))
            path.stroke()
        }
    }
}
