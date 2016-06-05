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
    var gamerState: COBGamerState? {
        didSet {
            updateViewsWithBeacons(beacons, gamerState: gamerState)
        }
    }
    var beacons: [COBBeacon]? {
        didSet {
            updateViewsWithBeacons(beacons, gamerState: gamerState)
        }
    }
    /// Array of beacons' views, ordered like knownBeacons
    var beaconsViews: [COBBeaconView]!
    var maxBeaconDistance: CGFloat { return min(beaconsView.bounds.width / 2, beaconsView.bounds.height) }
    var proximityRadiusStep: CGFloat { return maxBeaconDistance / 3 }
    var beaconAngleInitial: CGFloat { return CGFloat(M_PI) + beaconAngleStep }
    var beaconAngleStep: CGFloat { return CGFloat(M_PI / Double(COBBeacon.knownBeacons.count + 1)) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconsViews = [COBBeaconView]()
        for beacon in COBBeacon.knownBeacons {
            let beaconView = COBBeaconView(center: CGPointZero)
            beaconView.updateWithBeacon(beacon, andGamerState: nil)
            beaconsView.addSubview(beaconView)
            beaconsViews.append(beaconView)
        }
    }
    
    func updateViewsWithBeacons(beacons: [COBBeacon]?, gamerState: COBGamerState?) {
        if let beacons = beacons {
            for (index, beacon) in COBBeacon.knownBeacons.enumerate() {
                let beaconView = beaconsViews[index]
                let animated = beaconView.layer.opacity != 0
                if animated {
                    UIView.beginAnimations(nil, context: nil)
                    UIView.setAnimationCurve(.EaseInOut)
                    UIView.setAnimationDuration(0.5)
                }
                // If we detect the beacon, update with the newest info about it
                if let newBeaconIndex = beacons.indexOf(beacon) {
                    let newBeacon = beacons[newBeaconIndex]
                    beaconView.updateWithBeacon(newBeacon, andGamerState: gamerState)
                    if let proximity = newBeacon.proximity where proximity != .Unknown {
                        let angle = beaconAngleInitial + CGFloat(index) * beaconAngleStep
                        let radius = CGFloat(proximity.rawValue) * proximityRadiusStep
                        beaconView.frame.center = beaconsView.frame.bottomCenter.pointFor(angle, withRadius: radius)
                    }
                } else {
                    beaconView.updateWithBeacon(beacon, andGamerState: gamerState)
                }
                
                if animated {
                    UIView.commitAnimations()
                }
            }
        } else {
            beaconsViews.forEach({ $0.layer.opacity = 0 })
        }
    }
}
