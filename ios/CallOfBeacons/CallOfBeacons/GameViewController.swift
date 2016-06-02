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
            let cobBeacon = COBBeacon(beacon: beacon)
            if let index = COBConfiguration.beacons.indexOf({$0 == cobBeacon}) {
                let knownBeacon = COBConfiguration.beacons[index]
                cobBeacon.behavior = knownBeacon.behavior
                cobBeacon.name = knownBeacon.name
                print(cobBeacon)
            }
        }
        print("---")
    }

}
