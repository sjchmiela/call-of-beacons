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
    
    init(major: Int?, minor: Int?, behavior: String?, name: String?) {
        self.major = major
        self.minor = minor
        self.behavior = behavior
        self.name = name
    }
    
    var description: String {
        return "Beacon \(name) acting as \(behavior) (\((major ?? 0)!):\((minor ?? 0)!))"
    }
    
    convenience init(jsonData: JSON) {
        self.init(
            major: jsonData["major"].int,
            minor: jsonData["minor"].int,
            behavior: jsonData["behavior"].stringValue,
            name: jsonData["name"].stringValue
        )
    }

    convenience init(beacon: CLBeacon) {
        self.init(major: beacon.major.integerValue, minor: beacon.minor.integerValue, behavior: nil, name: nil)
    }
}

func ==(lhs: COBBeacon, rhs: COBBeacon) -> Bool {
    return lhs.major == rhs.major && lhs.minor == lhs.minor
}