//
//  GameViewController.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, ESTBeaconManagerDelegate {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var healthPointsLabel: UILabel!
    @IBOutlet weak var reviveButton: UIButton!
    @IBOutlet weak var killButton: UIButton!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: COBConfiguration.uuid!)!,
        identifier: "ranged region")
    
    var gamerState = COBGamerState() {
        didSet {
            healthPointsLabel?.text = "HP: \(gamerState.healthPoints)"
            scoreLabel?.text = "Score: \(gamerState.score)"
            reviveButton.hidden = !gamerState.canRevive
            killButton.hidden = gamerState.healthPoints == 0
            
            if gamerState.healthPoints > 0 {
                instructionsLabel.text = "Grab the flag!"
            } else {
                if gamerState.canRevive {
                    instructionsLabel.text = "Tap the revive button to revive."
                } else {
                    instructionsLabel.text = "Run to the nearest health point!"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    @IBAction func killTapped(sender: UIButton) {
        gamerState.kill()
    }
    
    @IBAction func reviveTapped(sender: UIButton) {
        gamerState.revive()
        
    }
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let cobBeacons = beacons.map { (clBeacon) -> COBBeacon in
            let cobBeacon = COBBeacon(beacon: clBeacon)
            if let behavior = cobBeacon.behavior {
                gamerState = behavior.beaconDidChangeProximity(cobBeacon, forGamerState: gamerState)
            }
            return cobBeacon
        }
        COBPositionNotifier.update(cobBeacons)
        print(cobBeacons)
        print("---")
    }

}
