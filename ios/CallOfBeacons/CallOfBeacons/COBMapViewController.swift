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
    var beaconsViews: [COBBeaconView]!
    var gamerState: COBGamerState! {
        return (parentViewController as! COBGameViewController).gamerState
    }
    var beacons: [COBBeacon]?  {
        didSet {
            if let beacons = beacons {
                for (index, beacon) in COBBeacon.knownBeacons.enumerate() {
                    if let index = beacons.indexOf(beacon) {
                        
                    }
                }
                for beacon in beacons {
                    let beaconView = beaconsViews[beacon]
                    beaconsViews.removeValueForKey(beacon)
                    beaconsViews[beacon] = beaconView
                }
                layoutBeacons()
            }
        }
    }
    var beaconsOrigin: CGPoint? {
        return beaconsView != nil ? CGPoint(x: beaconsView.bounds.midX, y: beaconsView.bounds.maxY) : nil
    }
    var maxDistance: CGFloat { return min(beaconsView.bounds.size.width / 2, beaconsView.bounds.size.height) }
    var proximityRadiusStep: CGFloat { return maxDistance / 3 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beaconsViews = [COBBeaconView]()
        for beacon in COBBeacon.knownBeacons {
            let beaconView = COBBeaconView(center: CGPoint(x: 0, y: 0))
            beaconView.updateWithBeacon(beacon, andGamerState: gamerState)
            beaconsView.addSubview(beaconView)
            beaconsViews.append(beaconView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutBeacons(false)
    }
    
    private func layoutBeacons(pulse: Bool = true) {
        if let beaconsViews = beaconsViews, let beaconsView = beaconsView {
            let angleStep = CGFloat(M_PI) / CGFloat(beaconsViews.count + 1)
            var beaconAngle = CGFloat(M_PI) + angleStep
            let origin = CGPoint(x: beaconsView.bounds.midX, y: beaconsView.bounds.maxY)
            for (beacon, view) in beaconsViews {
                if view.layer.opacity == 0 {
                    updateBeacon(beacon, view: view, angle: beaconAngle)
                } else {
                    UIView.animateWithDuration(0.3, animations: { 
                        updateBeacon(beacon, view: view, angle: beaconAngle)
                    })
                }
                
                if let behavior = beacon.behavior, let gamerState = self.gamerState where behavior.pulsating(beacon, forGamerState: gamerState) && pulse {
                    view.pulse()
                }
                beaconAngle += angleStep
            }
        }
    }
    
    private func updateBeacon(beacon: COBBeacon, view: COBBeaconView, angle: CGFloat) {
        
        view.updateWithBeacon(beacon, andGamerState: gamerState)
        if let proximity = beacon.proximity {
            view.frame.center = origin.pointFor(angle, withRadius: CGFloat(proximity.rawValue) * proximityRadiusStep)
        }
    }
}
