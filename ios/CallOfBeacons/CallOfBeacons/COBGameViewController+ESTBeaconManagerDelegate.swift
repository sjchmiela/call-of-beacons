//
//  COBGameViewController+ESTBeaconManagerDelegate.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 05.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation
import UIKit

extension COBGameViewController: ESTBeaconManagerDelegate {    
    /// Delegate method called when beacon manager detects beacons
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        // Map the CLBeacons to our COBBeacons
        let cobBeacons = beacons.map({COBBeacon(beacon: $0)})
        // For each COBBeacon trigger action
        for beacon in cobBeacons {
            if let behavior = beacon.behavior {
                gamerState = behavior.beaconIsInRange(beacon, forGamerState: gamerState)
            }
        }
        // Update positions on the server
        mapViewController.beacons = cobBeacons
        mapViewController.gamerState = gamerState
        update(gamerState, beacons: cobBeacons)
        updateUserInterface()
        
        // Print the beacon info to the console
        for beacon in cobBeacons {
            print(beacon)
        }
        print("---")
    }
}