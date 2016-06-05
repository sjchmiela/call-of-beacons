//
//  UIColor+HexString.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 04.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func cobBlueColor() -> UIColor {
        return UIColor(red:0.24, green:0.55, blue:0.73, alpha:1.00)
    }
    
    static func cobTextColor() -> UIColor {
        return UIColor(red:0.53, green:0.60, blue:0.65, alpha:1.00)
    }
    
    convenience init?(hexString: String?) {
        if let hexString = hexString {
            let hexString:NSString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            let scanner            = NSScanner(string: hexString as String)
            
            if (hexString.hasPrefix("#")) {
                scanner.scanLocation = 1
            }
            
            var color:UInt32 = 0
            scanner.scanHexInt(&color)
            
            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            
            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0
            
            self.init(red:red, green:green, blue:blue, alpha:1)
        } else {
            return nil
        }
    }
}