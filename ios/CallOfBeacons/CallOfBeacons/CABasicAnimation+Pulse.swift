//
//  CABasicAnimation+Pulse.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 05.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

extension CABasicAnimation {
    static func pulseAnimation(duration: NSTimeInterval, fromValue: CGFloat, toValue: CGFloat) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = FLT_MAX
        return animation
    }
}