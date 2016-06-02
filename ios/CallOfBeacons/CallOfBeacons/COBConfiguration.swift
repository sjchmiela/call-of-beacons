//
//  BeaconsConfiguration.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

class COBConfiguration {
    private static let path = NSBundle.mainBundle().pathForResource("beacons", ofType: "json")
    private static let data = try! NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe)
    private static let configuration = JSON(data: data)
    static let uuid = configuration["UUID"].string
    static var beacons: [COBBeacon] {
        return flags + bases
    }
    static var flags: [COBBeacon] {
        return configuration["flags"].array?.map({ (json) -> COBBeacon in
            return COBBeacon(major: json["major"].int, minor: json["minor"].int, name: "flag")
        }) ?? []
    }
    static var bases: [COBBeacon] {
        return configuration["bases"].array?.map({ (json) -> COBBeacon in
            return COBBeacon(major: json["major"].int, minor: json["minor"].int, name: "base")
        }) ?? []
    }
}