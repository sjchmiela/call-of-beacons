//
//  COBPositionNotifier.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation
import Alamofire

class COBPositionNotifier {
    static func update(beacons: [COBBeacon]) {
        let parameters = beacons.reduce([String: AnyObject]()) { (dictionary, beacon) -> [String: AnyObject] in
            var mutableDictionary = dictionary
            mutableDictionary["\(beacon.major!):\(beacon.minor!)"] = beacon.proximity?.rawValue
            return mutableDictionary
        }
        Alamofire.request(.PUT, COBConfiguration.putPositionUrl!, parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil)
    }
}