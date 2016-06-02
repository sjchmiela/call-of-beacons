//
//  COBBeacon.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

class COBBeacon: Equatable, CustomStringConvertible {
    init(major: Int?, minor: Int?, name: String) {
        self.major = major
        self.minor = minor
        self.name = name
    }
    
    convenience init(major: Int?, minor: Int?) {
        self.init(major: major, minor: minor, name: "unknown")
    }
    var major: Int?
    var minor: Int?
    var name: String
    var description: String {
        return "Beacon \(name) (\((major ?? 0)!):\((minor ?? 0)!))"
    }
}

func ==(lhs: COBBeacon, rhs: COBBeacon) -> Bool {
    return lhs.major == rhs.major && lhs.minor == lhs.minor
}