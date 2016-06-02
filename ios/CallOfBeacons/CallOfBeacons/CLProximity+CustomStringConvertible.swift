//
//  CLProximity+CustomStringConvertible.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

/// Extension to the CLProximity for nice string description
extension CLProximity {
    var description: String {
        switch self {
        case .Immediate:
            return "Immediate"
        case .Near:
            return "Near"
        case .Far:
            return "Far"
        default:
            return "Unknown"
        }
    }
}