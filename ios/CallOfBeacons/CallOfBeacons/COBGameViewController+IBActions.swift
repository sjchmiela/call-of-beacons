//
//  COBGameViewController+IBActions.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 05.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

extension COBGameViewController {
    @IBAction func hitButtonTapped(sender: UIButton) {
        gamerState.hit()
        updateUserInterface()
    }
    
    @IBAction func reviveTapped(sender: UIButton) {
        gamerState.revive()
        updateUserInterface()
    }
    
    @IBAction func exitButtonTapped(sender: UIButton) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pauseButtonTapped(sender: UIButton) {
        paused = true
        self.beaconManager.stopRangingBeaconsInRegion(beaconRegion)
        mapViewController.beacons = []
        updateUserInterface()
    }
    
    @IBAction func resumeButtonTapped(sender: UIButton) {
        paused = false
        self.beaconManager.startRangingBeaconsInRegion(beaconRegion)
        updateUserInterface()
    }
}