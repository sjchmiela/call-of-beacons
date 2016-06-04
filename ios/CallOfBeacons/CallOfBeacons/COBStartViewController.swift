//
//  COBStartViewController.swift
//  CallOfBeacons
//
//  Created by Stanisław Chmiela on 04.06.2016.
//  Copyright © 2016 Stanisław Chmiela, Rafał Żelazko. All rights reserved.
//

import UIKit

class COBStartViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GameStart" {
            let gameVC = segue.destinationViewController as! COBGameViewController
            gameVC.gamerState = COBGamerState(nick: nickTextField.text!)
        }
    }

    /// Called when the text field's value changes
    @IBAction func editingChanged(sender: UITextField) {
        if sender == nickTextField {
            if let text = sender.text where !text.isEmpty {
                joinButton.backgroundColor = UIColor(red:0.82, green:0.88, blue:0.24, alpha:1.00)
                joinButton.enabled = true
            } else {
                joinButton.backgroundColor = UIColor(red:0.60, green:0.67, blue:0.71, alpha:1.00)
                joinButton.enabled = false
            }
        }
    }
    
    /// Whether the return button on the keyboard should be enabled or not
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nickTextField {
            if let text = textField.text where !text.isEmpty {
                textField.resignFirstResponder()
                return true
            } else {
                return false
            }
        }
        
        return true
    }
    
    /// Status bar style for the View Controller
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
