//
//  COBPositionNotifier.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation
import Alamofire

/// Object notifying server of the beacon positions
class COBPositionNotifier {
    /// Where the notifier should put the positions
    var url: String?
    
    init(url: String) {
        self.url = url
    }
    
    /// Send to the server
    func update(beacons: [COBBeacon]) {
        if let url = url {
            Alamofire.request(.PUT, url, parameters: COBPositionNotifier.beaconsToParameters(beacons), encoding: ParameterEncoding.JSON, headers: nil)
        }
    }
    
    /// Turn array of beacons to parameters sendable through HTTP request
    static func beaconsToParameters(beacons: [COBBeacon]) -> [String: AnyObject] {
        let initialDictionary = [String: AnyObject]()
        return beacons.reduce(initialDictionary) { (dictionary, beacon) -> [String: AnyObject] in
            if let proximity = beacon.proximity {
                var mutableDictionary = dictionary
                mutableDictionary["\(beacon.major!):\(beacon.minor!)"] = proximity.rawValue
                return mutableDictionary
            } else {
                return dictionary
            }
        }
    }
}