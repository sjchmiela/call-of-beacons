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
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var healthPointsButton: UIButton!
    @IBOutlet weak var scoreLabel: UICountingLabel!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    /// Beacon Manager
    let beaconManager = ESTBeaconManager()
    /// Region that the beacon manager ranges
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: COBConfiguration.uuid!)!,
        identifier: "ranged region")
    let notifier = COBPositionNotifier(url: COBConfiguration.putPositionUrl!)
    
    /// Gamer state represented on screen
    var gamerState: COBGamerState! {
        // On every gamer state change update UI
        didSet {
            self.updateUserInterface()
        }
    }
    
    var mapViewController: COBMapViewController? {
        return childViewControllers.filter({ $0 is COBMapViewController }).first as? COBMapViewController
    }
    
    let pulseAnimation: CABasicAnimation = {
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = FLT_MAX
        return pulseAnimation
    }()
    
    // MARK: - Object Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        scoreLabel.format = "Score: %d"
        scoreLabel.animationDuration = 0.5
        scoreLabel.method = UILabelCountingMethod.EaseInOut
        scoreLabel.countFromZeroTo(0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
        self.updateUserInterface()
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    private func updateUserInterface() {
        nickLabel?.text = gamerState.nick.uppercaseString
        scoreLabel?.countFromCurrentValueTo(CGFloat(gamerState.score))
        
        healthPointsButton?.setTitle("HP: \(gamerState.healthPoints)", forState: UIControlState.Normal)
        healthPointsButton?.enabled = gamerState.canRevive
        
        if gamerState.canRevive {
            healthPointsButton?.setTitleColor(UIColor(red:0.24, green:0.55, blue:0.73, alpha:1.00), forState: UIControlState.Normal)
            healthPointsButton?.titleLabel?.layer.addAnimation(pulseAnimation, forKey: nil)
        } else {
            healthPointsButton?.setTitleColor(UIColor(red:0.53, green:0.60, blue:0.65, alpha:1.00), forState: UIControlState.Normal)
            healthPointsButton?.titleLabel?.layer.removeAllAnimations()
        }
        
        hitButton?.hidden = gamerState.healthPoints == 0
        
        if gamerState.healthPoints > 0 {
            instructionsLabel?.text = "Grab the flag!"
        } else {
            if gamerState.canRevive {
                instructionsLabel?.text = "Tap the revive button to revive."
            } else {
                instructionsLabel?.text = "Run to the nearest health point!"
            }
        }
    }
    
    // MARK: - Button actions
    
    @IBAction func hitButtonTapped(sender: UIButton) {
        gamerState.kill()
        updateUserInterface()
    }
    
    @IBAction func reviveTapped(sender: UIButton) {
        gamerState.revive()
        updateUserInterface()
    }
    
    @IBAction func resetButtonTapped(sender: UIButton) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
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
        
        mapViewController?.beacons = cobBeacons
        mapViewController?.gamerState = gamerState
        
        // Print the beacon info to the console
        for beacon in cobBeacons {
            print(beacon)
        }
        print("---")
    }
}
