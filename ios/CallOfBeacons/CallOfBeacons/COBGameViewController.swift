//
//  GameViewController.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import UIKit

class COBGameViewController: UIViewController, ESTBeaconManagerDelegate {
    /// Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var healthPointsLabel: UILabel!
    @IBOutlet weak var reviveButton: UIButton!
    @IBOutlet weak var killButton: UIButton!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    /// Beacon Manager
    let beaconManager = ESTBeaconManager()
    /// Region that the beacon manager ranges
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: COBConfiguration.uuid!)!,
        identifier: "ranged region")
    let notifier = COBPositionNotifier(url: COBConfiguration.putPositionUrl!)
    
    /// Gamer state represented on screen
    var gamerState = COBGamerState() {
        // On every gamer state change update UI
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
    
    // MARK: - Object Lifecycle
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
    
    // MARK: - Button actions
    
    @IBAction func killTapped(sender: UIButton) {
        gamerState.kill()
    }
    
    @IBAction func reviveTapped(sender: UIButton) {
        gamerState.revive()
        
    }
    
    // MARK: - ESTBeaconManagerDelegate
    
    /// Delegate method called when beacon manager detects beacons
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        // Map the CLBeacons to our COBBeacons
        let cobBeacons = beacons.map({COBBeacon(beacon: $0)})
        // For each COBBeacon trigger action
        for beacon in cobBeacons {
            if let behavior = beacon.behavior {
                gamerState = behavior.beaconIsInRange(beacon, forGamerState: gamerState)
            }
        }
        // Update positions on the server
        notifier.update(cobBeacons)
        
        // Print the beacon info to the console
        for beacon in cobBeacons {
            print(beacon)
        }
        print("---")
    }

}
