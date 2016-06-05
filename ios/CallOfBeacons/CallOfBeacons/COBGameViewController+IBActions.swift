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
        pause()
    }
    
    func pause() {
        paused = true
        beaconManager.stopRangingBeaconsInRegion(beaconRegion)
        mapViewController.beacons = []
        updateUserInterface()
    }
    
    @IBAction func resumeButtonTapped(sender: UIButton) {
        if bluetoothManager.state != .PoweredOn {
            centralManagerDidUpdateState(bluetoothManager)
        } else {
            paused = false
            beaconManager.startRangingBeaconsInRegion(beaconRegion)
            updateUserInterface()
        }
    }
}