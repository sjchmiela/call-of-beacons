//
//  BeaconsConfiguration.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

class COBConfiguration {
    private static let path = NSBundle.mainBundle().pathForResource("configuration", ofType: "json")
    private static let data = try! NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe)
    private static let configuration = JSON(data: data)

    static let uuid = configuration["UUID"].string

    static var beacons: [COBBeacon] {
        return configuration["beacons"].arrayValue.map({COBBeacon(jsonData: $0)})
    }
    static var flags: [COBBeacon] {
        return beacons.filter({ $0.behavior == "flag" })
    }
    static var healthPoints: [COBBeacon] {
        return beacons.filter({ $0.behavior == "health" })
    }
}