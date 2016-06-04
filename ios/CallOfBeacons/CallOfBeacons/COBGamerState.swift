//
//  COBGamerState.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

/// Gamer State object – holds health points and score
class COBGamerState {
    /// Nick of the gamer
    var nick: String
    /// Health points of the gamer
    var healthPoints: Int = 100
    /// Score of the gamer
    var score: Int = 0
    var canRevive: Bool = false
    
    init(nick: String) {
        self.nick = nick
    }
    
    /// Called when the gamer is revived. Every revival deducts points.
    func revive() {
        score -= COBConfiguration.revivalPenalty
        healthPoints = 100
    }
    
    /// Called when the gamer is killed.
    func kill() {
        healthPoints = 0
    }
}