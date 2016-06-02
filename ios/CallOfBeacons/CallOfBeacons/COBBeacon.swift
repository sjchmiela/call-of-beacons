//
//  COBBeacon.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

class COBBeacon: Equatable, CustomStringConvertible {
    var major: Int?
    var minor: Int?
    var name: String?
    var behavior: String?
    var proximity: CLProximity?
    
    var description: String {
        return "Beacon \(name ?? "") acting as \(behavior ?? "unknown") (\(major?.description ?? "?"):\((minor?.description ?? "?"))) is in proximity \(proximity?.description ?? "unknown")"
    }
    
    init(jsonData: JSON) {
        self.major = jsonData["major"].int
        self.minor = jsonData["minor"].int
        self.behavior = jsonData["behavior"].string
        self.name = jsonData["name"].string
    }

    init(beacon: CLBeacon) {
        self.major = beacon.major.integerValue
        self.minor = beacon.minor.integerValue
        self.proximity = beacon.proximity
    }
}

func ==(lhs: COBBeacon, rhs: COBBeacon) -> Bool {
    return lhs.major == rhs.major && lhs.minor == rhs.minor
}