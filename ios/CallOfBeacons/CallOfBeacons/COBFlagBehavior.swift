//
//  COBFlagBehavior.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

class COBFlagBehavior: COBBeaconBehavior {
    static func beaconIsInRange(beacon: COBBeacon, forGamerState gamerState: COBGamerState) -> COBGamerState {
        // If the gamer is alive
        if gamerState.healthPoints > 0 {
            // Add to the score points based on the proximity.
            if let proximity = beacon.proximity {
                switch proximity {
                case .Immediate:
                    gamerState.score += 10
                case .Near:
                    gamerState.score += 5
                case .Far:
                    gamerState.score += 2
                default:
                    break
                }
            }
        }
        
        return gamerState
    }
    
    static func highlighted(beacon: COBBeacon, forGamerState gamerState: COBGamerState) -> Bool {
        if let proximity = beacon.proximity where proximity != .Unknown && gamerState.isScoring {
            return true
        }
        return false
    }
    
    static func pulsating(beacon: COBBeacon, forGamerState gamerState: COBGamerState) -> Bool {
        if let proximity = beacon.proximity where proximity != .Unknown && gamerState.isScoring {
            return true
        }
        return false
    }
}