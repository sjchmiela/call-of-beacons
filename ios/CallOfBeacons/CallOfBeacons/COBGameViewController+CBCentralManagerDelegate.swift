//
//  COBGameViewController+CBCentralManagerDelegate.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 05.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import Foundation

extension COBGameViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case .Unsupported:
            pause()
            showBluetoothUnsupportedAlert()
        case .PoweredOff:
            pause()
            showBluetoothOffAlert()
        case .Unauthorized:
            pause()
            showBluetoothUnauthorizedAlert()
        default:
            return
        }
    }
    
    func showBluetoothOffAlert() {
        let alertController = UIAlertController(title: "Bluetooth powered off", message: "To use the application you have to have your Bluetooth enabled.", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showBluetoothUnsupportedAlert() {
        let alertController = UIAlertController(title: "Bluetooth unsupported", message: "To use the application your device must support Bluetooth connectivity.", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showBluetoothUnauthorizedAlert() {
        let alertController = UIAlertController(title: "App unauthorized to use Bluetooth", message: "To use the application the application has to be authorized to use Bluetooth. Check your device settings.", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}