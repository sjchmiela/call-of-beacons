//
//  COBHealthPointBehavior.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

class COBHealthPointBehavior: COBBeaconBehavior {
    static func beaconIsInRange(beacon: COBBeacon, forGamerState gamerState: COBGamerState) -> COBGamerState {
        // If the health beacon is in immediate proximity the gamer can revive.
        gamerState.canRevive = (beacon.proximity == .Immediate)
        return gamerState
    }
    
    static func highlighted(beacon: COBBeacon, forGamerState gamerState: COBGamerState) -> Bool {
        return gamerState.shouldRevive
    }
    
    static func pulsating(beacon: COBBeacon, forGamerState gamerState: COBGamerState) -> Bool {
        return false
    }
}