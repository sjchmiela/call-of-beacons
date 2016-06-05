//
//  COBBeaconView.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 04.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import UIKit

@IBDesignable
class COBBeaconView: UIView {
    var shapeLayer: CAShapeLayer!
    @IBInspectable var fillColor: UIColor? {
        didSet {
            shapeLayer.fillColor = fillColor?.CGColor
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            shapeLayer.strokeColor = borderColor?.CGColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shapeLayerInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shapeLayerInit()
    }
    
    convenience init(center: CGPoint) {
        self.init(frame: CGRect(x: center.x - 17, y: center.y - 24, width: 34, height: 48))
    }
    
    func pulse() {
        layer.insertSublayer(LFTPulseAnimation(repeatCount: 1, radius: 40, position: bounds.center), below: shapeLayer)
    }
    
    func updateWithBeacon(beacon: COBBeacon?, andGamerState gamerState: COBGamerState?) {
        if let beacon = beacon {
            fillColor = UIColor(hexString: beacon.color) ?? UIColor.whiteColor()
            
            if let behavior = beacon.behavior, let gamerState = gamerState where behavior.highlighted(beacon, forGamerState: gamerState) {
                borderColor = UIColor.whiteColor()
            } else {
                borderColor = UIColor.blackColor()
            }
            
            if let proximity = beacon.proximity where proximity != .Unknown {
                layer.opacity = 1
            } else {
                layer.opacity = 0.5
            }
        } else {
            layer.opacity = 0
        }
    }
    
    private func shapeLayerInit() {
        shapeLayer = CAShapeLayer()
        shapeLayer.path = drawing.CGPath
        shapeLayer.fillColor = UIColor.whiteColor().CGColor
        shapeLayer.strokeColor = UIColor.blackColor().CGColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.position = CGPoint(x: 0, y: 0)
        layer.addSublayer(shapeLayer)
    }
    
    let drawing: UIBezierPath = {
        //// PaintCode Trial Version
        //// www.paintcodeapp.com
        
        //// layer1
        //// path6017 Drawing
        let path6017Path = UIBezierPath()
        path6017Path.moveToPoint(CGPoint(x: 17.35, y: 8.63))
        path6017Path.addLineToPoint(CGPoint(x: 17.35, y: 8.63))
        path6017Path.addCurveToPoint(CGPoint(x: 16.55, y: 9.43), controlPoint1: CGPoint(x: 17.35, y: 9.07), controlPoint2: CGPoint(x: 16.99, y: 9.43))
        path6017Path.addLineToPoint(CGPoint(x: 16.55, y: 9.43))
        path6017Path.addCurveToPoint(CGPoint(x: 15.75, y: 8.63), controlPoint1: CGPoint(x: 16.11, y: 9.43), controlPoint2: CGPoint(x: 15.75, y: 9.07))
        path6017Path.addLineToPoint(CGPoint(x: 15.75, y: 8.63))
        path6017Path.addCurveToPoint(CGPoint(x: 16.55, y: 7.83), controlPoint1: CGPoint(x: 15.75, y: 8.18), controlPoint2: CGPoint(x: 16.11, y: 7.83))
        path6017Path.addLineToPoint(CGPoint(x: 16.55, y: 7.83))
        path6017Path.addCurveToPoint(CGPoint(x: 17.35, y: 8.63), controlPoint1: CGPoint(x: 16.99, y: 7.83), controlPoint2: CGPoint(x: 17.35, y: 8.18))
        path6017Path.closePath()
        path6017Path.moveToPoint(CGPoint(x: 23.18, y: 1.79))
        path6017Path.addLineToPoint(CGPoint(x: 21.93, y: 3.31))
        path6017Path.addLineToPoint(CGPoint(x: 8.21, y: 4.47))
        path6017Path.addLineToPoint(CGPoint(x: 7.59, y: 5.71))
        path6017Path.addLineToPoint(CGPoint(x: 9.46, y: 33.16))
        path6017Path.addLineToPoint(CGPoint(x: 3.58, y: 36.37))
        path6017Path.addLineToPoint(CGPoint(x: 1.53, y: 34.32))
        path6017Path.addLineToPoint(CGPoint(x: 3.13, y: 40.11))
        path6017Path.addLineToPoint(CGPoint(x: 5.63, y: 40.29))
        path6017Path.addLineToPoint(CGPoint(x: 18.73, y: 45.99))
        path6017Path.addLineToPoint(CGPoint(x: 20.24, y: 47.24))
        path6017Path.addLineToPoint(CGPoint(x: 26.66, y: 45.37))
        path6017Path.addLineToPoint(CGPoint(x: 27.99, y: 44.75))
        path6017Path.addLineToPoint(CGPoint(x: 27.37, y: 43.14))
        path6017Path.addLineToPoint(CGPoint(x: 20.33, y: 45.01))
        path6017Path.addLineToPoint(CGPoint(x: 18.82, y: 45.91))
        path6017Path.addLineToPoint(CGPoint(x: 5.45, y: 40.2))
        path6017Path.addLineToPoint(CGPoint(x: 3.49, y: 36.37))
        path6017Path.addLineToPoint(CGPoint(x: 9.37, y: 33.16))
        path6017Path.addLineToPoint(CGPoint(x: 14, y: 34.85))
        path6017Path.addLineToPoint(CGPoint(x: 20.42, y: 45.01))
        path6017Path.addLineToPoint(CGPoint(x: 27.28, y: 43.05))
        path6017Path.addLineToPoint(CGPoint(x: 32.09, y: 32.45))
        path6017Path.addLineToPoint(CGPoint(x: 32.18, y: 29.6))
        path6017Path.addLineToPoint(CGPoint(x: 28.35, y: 18.37))
        path6017Path.addLineToPoint(CGPoint(x: 25.23, y: 5.18))
        path6017Path.addLineToPoint(CGPoint(x: 25.5, y: 2.68))
        path6017Path.addLineToPoint(CGPoint(x: 25.32, y: 5.09))
        path6017Path.addLineToPoint(CGPoint(x: 22.02, y: 3.4))
        path6017Path.addLineToPoint(CGPoint(x: 25.14, y: 5.18))
        path6017Path.addLineToPoint(CGPoint(x: 28.44, y: 18.55))
        path6017Path.addLineToPoint(CGPoint(x: 14, y: 34.68))
        path6017Path.addLineToPoint(CGPoint(x: 9.28, y: 33.25))
        path6017Path.addLineToPoint(CGPoint(x: 7.5, y: 6.07))
        path6017Path.addLineToPoint(CGPoint(x: 8.39, y: 4.56))
        path6017Path.addLineToPoint(CGPoint(x: 22.02, y: 3.31))
        path6017Path.addLineToPoint(CGPoint(x: 25.32, y: 5.09))
        path6017Path.addLineToPoint(CGPoint(x: 25.59, y: 2.68))
        path6017Path.addLineToPoint(CGPoint(x: 23.18, y: 1.79))
        path6017Path.closePath()
        path6017Path.moveToPoint(CGPoint(x: 8.92, y: 2.95))
        path6017Path.addLineToPoint(CGPoint(x: -0.34, y: 24.87))
        path6017Path.addLineToPoint(CGPoint(x: 2.86, y: 40.02))
        path6017Path.addLineToPoint(CGPoint(x: 4.56, y: 42.52))
        path6017Path.addLineToPoint(CGPoint(x: 16.77, y: 47.86))
        path6017Path.addLineToPoint(CGPoint(x: 20.24, y: 47.42))
        path6017Path.addLineToPoint(CGPoint(x: 26.66, y: 45.46))
        path6017Path.addLineToPoint(CGPoint(x: 31.56, y: 42.25))
        path6017Path.addLineToPoint(CGPoint(x: 32.27, y: 31.47))
        path6017Path.addLineToPoint(CGPoint(x: 31.29, y: 16.14))
        path6017Path.addLineToPoint(CGPoint(x: 27.28, y: 4.29))
        path6017Path.addLineToPoint(CGPoint(x: 25.77, y: 2.77))
        path6017Path.addLineToPoint(CGPoint(x: 23.36, y: 1.79))
        path6017Path.addLineToPoint(CGPoint(x: 16.77, y: 0.28))
        path6017Path.addLineToPoint(CGPoint(x: 8.92, y: 2.95))
        path6017Path.closePath()
        path6017Path.miterLimit = 4;
        
        path6017Path.lineCapStyle = .Round;
        
        return path6017Path
    }()
}
