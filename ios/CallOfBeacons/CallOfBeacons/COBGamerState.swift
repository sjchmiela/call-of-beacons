//
//  COBGamerState.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

/// Gamer State object – holds health points and score
class COBGamerState: CustomStringConvertible {
    /// Nick of the gamer
    var nick: String
    /// Health points of the gamer
    var healthPoints: Int = 100 {
        didSet {
            if healthPoints < 0 { healthPoints = 0 }
        }
    }
    /// Score of the gamer
    var score: Int = 0
    var canRevive: Bool = false {
        didSet {
            if canRevive == true && healthPoints == 100 {
                canRevive = false
            }
        }
    }
    var isScoring: Bool {
        return healthPoints > 0
    }
    var shouldRevive: Bool {
        return healthPoints == 0
    }
    var description: String {
        return "State for gamer \(nick)\n\tHP: \(healthPoints)\n\tScore: \(score)"
    }
    
    init(nick: String) {
        self.nick = nick
    }
    
    /// Called when the gamer is revived. Every revival deducts points.
    func revive() {
        score -= COBConfiguration.revivalPenalty
        healthPoints = 100
    }
    
    /// Called when the gamer is killed.
    func hit() {
        healthPoints -= 20
    }
}