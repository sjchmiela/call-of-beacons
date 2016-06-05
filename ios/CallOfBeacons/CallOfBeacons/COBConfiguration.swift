//
//  BeaconsConfiguration.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

/// Configuration class
class COBConfiguration {
    /// Internal path of the configuration file
    private static let path = NSBundle.mainBundle().pathForResource("configuration", ofType: "json")!
    /// Configuration dictionary read from JSON
    private static let configuration = try! JSON(data: NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe))

    /// UUID we should listen on
    static let uuid = configuration["UUID"].string
    /// URL to send positions to
    static let putPositionUrl = configuration["putPositionUrl"].string
    /// Array of all the known beacons
    static let beacons: [COBBeacon] = {
        return configuration["beacons"].arrayValue.map({COBBeacon(jsonData: $0)})
    }()
    /// Array of beacons acting as flags
    static var flags: [COBBeacon] = {
        return beacons.filter({ $0.behaviorName == "flag" })
    }()
    /// Array of beacons acting as health points
    static var healthPoints: [COBBeacon] = {
        return beacons.filter({ $0.behaviorName == "healthPoint" })
    }()
    /// Amount of points deducted from gamer's score when on revival
    static let revivalPenalty: Int = { return configuration["revivalPenalty"].int ?? 0 }()
    static let hitDeduction: Int = { return configuration["hitDeduction"].int ?? 0 }()
    /// Dictionary of proximity -> score
    static let proximityToScore: [CLProximity: Int] = {
        var proximityToScore = [CLProximity: Int]()
        
        if let proximityTable = configuration["proximityToScore"].dictionaryObject {
            for (proximityString, score) in proximityTable {
                if let proximityInt = Int(proximityString),
                    let proximity = CLProximity(rawValue: proximityInt) {
                    proximityToScore[proximity] = score.integerValue
                }
            }
        }
        
        return proximityToScore
    }()
}