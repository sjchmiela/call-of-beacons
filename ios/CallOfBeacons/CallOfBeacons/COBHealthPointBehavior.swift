//
//  COBHealthPointBehavior.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

class COBHealthPointBehavior: COBBeaconBehavior {
    func beaconDidChangeProximity(beacon: COBBeacon, forGamerState gamerState: COBGamerState) -> COBGamerState {
        gamerState.canRevive = (beacon.proximity == .Immediate)
        return gamerState
    }
}