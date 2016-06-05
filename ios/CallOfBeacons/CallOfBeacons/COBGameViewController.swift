//
//  GameViewController.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 02.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import UIKit

class COBGameViewController: UIViewController {
    /// Outlets
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var healthPointsButton: UIButton!
    @IBOutlet weak var scoreLabel: UICountingLabel!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    /// Map view controller shortcut
    var mapViewController: COBMapViewController! {
        return childViewControllers.filter({ $0 is COBMapViewController }).first as! COBMapViewController
    }
    
    /// Beacon Manager
    let beaconManager = ESTBeaconManager()
    /// Region that the beacon manager ranges
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: COBConfiguration.uuid!)!,
        identifier: "ranged region")
    var bluetoothManager: CBCentralManager!
    let notifier = COBPositionNotifier(url: COBConfiguration.putPositionUrl!)
    
    /// Gamer state represented on screen
    var gamerState: COBGamerState!
    var paused = false
    
    // MARK: - Object Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beaconManager.delegate = self
        self.beaconManager.requestWhenInUseAuthorization()
        scoreLabel.format = "Score: %d"
        scoreLabel.animationDuration = 0.5
        scoreLabel.method = UILabelCountingMethod.EaseInOut
        scoreLabel.countFromZeroTo(0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if !paused {
            self.beaconManager.startRangingBeaconsInRegion(beaconRegion)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(COBGameViewController.pauseButtonTapped), name: UIApplicationDidEnterBackgroundNotification, object: nil)
        bluetoothManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: false])
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        paused = true
        self.beaconManager.stopRangingBeaconsInRegion(beaconRegion)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        bluetoothManager = nil
    }
    
    func updateUserInterface() {
        hitButton.hidden = paused
        pauseButton.hidden = paused
        resumeButton.hidden = !paused
        exitButton.hidden = !paused
        
        nickLabel.text = gamerState.nick
        scoreLabel.countFromCurrentValueTo(CGFloat(gamerState.score))
        healthPointsButton.setTitle("HP: \(gamerState.healthPoints)", forState: .Normal)
        
        if gamerState.canRevive {
            healthPointsButton.titleLabel!.layer.addAnimation(CABasicAnimation.pulseAnimation(0.5, fromValue: 1, toValue: 0.5), forKey: nil)
            healthPointsButton.setTitleColor(UIColor.cobBlueColor(), forState: .Normal)
        } else {
            healthPointsButton.titleLabel!.layer.removeAllAnimations()
            healthPointsButton.setTitleColor(UIColor.cobTextColor(), forState: .Normal)
        }
        
        if paused {
            instructionsLabel.text = "Game paused"
        } else {
            instructionsLabel.text = gamerState.instructionText
        }
    }
}
