//
//  COBBeacon.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

/// Beacon model with all the information we need
class COBBeacon: Equatable, CustomStringConvertible, Hashable, Comparable {
    /// Major of the beacon
    var major: Int?
    /// Minor of the beacon
    var minor: Int?
    /// Name of the beacon (customizable in configuration.json)
    var name: String?
    /// Behavior of the beacon (based on which we'll decide how to handle it's proximity)
    var behaviorName: String?
    /// Proximity of the beacon to the gamer
    var proximity: CLProximity?
    /// Color of the beacon
    var color: String?
    /// toString of the beacon object
    var description: String {
        return "Beacon \(name ?? "")\n\t\(proximity?.description ?? "unknown") to \(behaviorName ?? "unknown")"
    }
    /// Behavior of the beacon
    var behavior: COBBeaconBehavior.Type? {
        if let behaviorName = behaviorName, let behaviorType = COBBeacon.behaviors[behaviorName] {
            return behaviorType
        } else {
            return nil
        }
    }
    
    var shouldPulse: Bool {
        return behaviorName == "flag"
    }
    
    /// Initialize out of JSON
    init(jsonData: JSON) {
        self.major = jsonData["major"].int
        self.minor = jsonData["minor"].int
        self.behaviorName = jsonData["behavior"].string
        self.name = jsonData["name"].string
        self.color = jsonData["color"].string
    }

    /// Initialize out of a beacon of another type. Merges the beacon with any known beacon found.
    init(beacon: CLBeacon) {
        self.major = beacon.major.integerValue
        self.minor = beacon.minor.integerValue
        self.proximity = beacon.proximity
        
        if let knownBeacon = COBBeacon.beaconWith(beacon.major.integerValue, minor: beacon.minor.integerValue) {
            self.name = knownBeacon.name
            self.behaviorName = knownBeacon.behaviorName
            self.color = knownBeacon.color
        }
    }
    
    var hashValue: Int {
        return 65535 * major! + minor!
    }
}

extension COBBeacon {
    /// All the known behaviorNames and their behaviors
    static let behaviors: [String: COBBeaconBehavior.Type] = {
        return [
            "flag": COBFlagBehavior.self,
            "healthPoint": COBHealthPointBehavior.self
        ]
    }()
    
    /// All the known beacons
    static var knownBeacons: [COBBeacon] {
        return COBConfiguration.beacons.sort()
    }
    
    /// Find one beacon with these major and minor out of all the known beacons
    static func beaconWith(major: Int, minor: Int) -> COBBeacon? {
        if let index = knownBeacons.indexOf({$0.major == major && $0.minor == minor}) {
            return knownBeacons[index]
        }
        
        return nil
    }
    
    /// Turn array of beacons to parameters sendable through HTTP request
    static func beaconsToParameters(beacons: [COBBeacon]) -> [AnyObject] {
        return beacons.map({ (beacon) -> AnyObject in
            return [
                "major": beacon.major!,
                "minor": beacon.minor!,
                "proximity": beacon.proximity?.rawValue ?? 0
            ]
        })
    }
}

/// Comparison implementation
func ==(lhs: COBBeacon, rhs: COBBeacon) -> Bool {
    return lhs.major == rhs.major && lhs.minor == rhs.minor
}

func <(lhs: COBBeacon, rhs: COBBeacon) -> Bool {
    return lhs.major == rhs.major ? lhs.minor < rhs.minor : lhs.major < rhs.major
}