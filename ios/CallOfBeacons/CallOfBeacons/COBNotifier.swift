//
//  COBNotifier.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 06.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

protocol COBNotifier {
    func update(gamerState: COBGamerState, beacons: [COBBeacon]) -> Void
}