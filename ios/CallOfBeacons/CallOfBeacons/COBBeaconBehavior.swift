//
//  COBBeaconBehavior.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

/// Behavior protocol (interface)
protocol COBBeaconBehavior {
    /// Mutates gamerState based on the proximity of the beacon
    func beaconIsInRange(beacon: COBBeacon, forGamerState gamerState: COBGamerState) -> COBGamerState
}