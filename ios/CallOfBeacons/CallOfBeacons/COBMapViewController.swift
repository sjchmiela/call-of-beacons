//
//  COBMapViewController.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 04.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import UIKit

class COBMapViewController: UIViewController {
    @IBOutlet weak var beaconsView: UIView!
    var beaconsViews: [COBBeacon: COBBeaconView]!
    var beacons: [COBBeacon]?  {
        didSet {
            if let beacons = beacons where beaconsViews != nil {
                for beacon in beacons {
                    let beaconView = beaconsViews[beacon]
                    beaconsViews.removeValueForKey(beacon)
                    beaconsViews[beacon] = beaconView
                }
                layoutBeacons()
            }
        }
    }
    var maxDistance: CGFloat { return min(beaconsView.bounds.size.width / 2, beaconsView.bounds.size.height) }
    var proximityRadiusStep: CGFloat { return maxDistance / 3 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconsViews = [COBBeacon: COBBeaconView]()
        for beacon in COBBeacon.knownBeacons.sort({ $0.major == $1.major ? $0.minor < $1.minor : $0.major < $1.minor }) {
            let beaconView = COBBeaconView(center: CGPoint(x: 0, y: 0))
            if let color = beacon.color {
                beaconView.fillColor = UIColor(hexString: color)
            }
            beaconView.hidden = true
            beaconsView.addSubview(beaconView)
            if let index = beacons?.indexOf({$0 == beacon}) {
                beaconsViews[beacons![index]] = beaconView
            } else {
                beaconsViews[beacon] = beaconView
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutBeacons()
    }
    
    private func layoutBeacons() {
        if let beaconsViews = beaconsViews, let beaconsView = beaconsView {
            let angleStep = (CGFloat(M_PI) / CGFloat(beaconsViews.count + 1))
            var beaconAngle: CGFloat = CGFloat(M_PI) + angleStep
            let origin = CGPoint(x: beaconsView.bounds.midX, y: beaconsView.bounds.maxY)
            for (beacon, view) in beaconsViews {
                if let proximity = beacon.proximity {
                    if proximity == .Unknown {
                        view.layer.opacity = 0.5
                        view.hidden = false
                    } else {
                        view.hidden = false
                        view.layer.opacity = 1
                        view.frame.center = pointFor(beaconAngle, originatingFrom: origin, withRadius: CGFloat(proximity.rawValue) * proximityRadiusStep)
                    }
                    print(view.frame)
                }
                beaconAngle += angleStep
            }
        }
    }
    
    private func pointFor(angle: CGFloat, originatingFrom origin: CGPoint, withRadius radius: CGFloat) -> CGPoint {
        let x = cos(angle) * radius + origin.x
        let y = sin(angle) * radius + origin.y
        return CGPoint(x: x, y: y)
    }
}
