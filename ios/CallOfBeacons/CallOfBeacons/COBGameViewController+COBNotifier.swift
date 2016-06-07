//
//  COBGameViewController+COBNotifier.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 06.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation
import Alamofire

extension COBGameViewController: COBNotifier {
    func update(gamerState: COBGamerState, beacons: [COBBeacon]) -> Void {
        if let url = notifyUrl {
            let beaconParameters = COBBeacon.beaconsToParameters(beacons)
            let gamerParameters = gamerState.toParameters()
            let parameters = [
                "gamer": gamerParameters,
                "beacons": beaconParameters
            ]
            Alamofire.request(.PUT, url, parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).validate()
        }
    }
}