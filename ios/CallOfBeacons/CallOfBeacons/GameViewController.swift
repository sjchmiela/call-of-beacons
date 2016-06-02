//
//  GameViewController.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, ESTBeaconManagerDelegate {
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: COBConfiguration.uuid!)!,
        identifier: "ranged region")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    @IBAction func killTapped(sender: UIButton) {
        print("KILLED")
    }
    
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        for beacon in beacons {
            let foundBeacon = COBBeacon(major: beacon.major.integerValue, minor: beacon.minor.integerValue)
            for knownBeacon in COBConfiguration.beacons {
                if knownBeacon == foundBeacon {
                    foundBeacon.name = knownBeacon.name
                }
            }
            
            switch beacon.proximity {
            case CLProximity.Far:
                print("\(foundBeacon) is far")
            case CLProximity.Immediate:
                print("\(foundBeacon) is very close")
            case CLProximity.Near:
                print("\(foundBeacon) is near")
            default:
                print("\(foundBeacon)'s location is unknown")
            }
        }
        print("---")
    }

}
