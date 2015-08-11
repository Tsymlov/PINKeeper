//
//  ViewController.swift
//  PINKeeper
//
//  Created by Alexey Tsymlov on 8/9/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: UIViewController {
    
    struct Constants {
        static let DigitButtonWidthToTitleFontSizeRatio: CGFloat = 0.45
    }
    
    // MARK: - Properties
    
    @IBOutlet var digitButtons: [UIButton]!
    
    private let context = LAContext()
    
    // MARK: - ViewController life cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            AppDelegate.restrictRotation = true
        }
        authenticateUserWithTouchID()
    }
    
    private func authenticateUserWithTouchID(){
        var error: NSError?
        if !checkIfTouchIDIsAvailable(&error) {
            println("Touch ID is not available")
            //TODO: Go to the passcode enter.
            return
        }
        
        let reason = "Use your fingerprint to log in."
        context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
            {(succes: Bool, error: NSError!) in
                if succes {
                    println("Touch ID Authentication Succeeded")
                    //TODO: Go to the PINs.
                }
                else {
                    println("Touch ID Authentication Failed")
                    //TODO: Separate reasons of fail.
                    //TODO: Show the message about blocking touch ID and go to the passcode enter.
                }
        })
    }
    
    private func checkIfTouchIDIsAvailable(inout error: NSError?)->Bool{
        return context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    override func viewDidLayoutSubviews() {
        setAllDigitButtonsRounded()
        refreshDigitButtonsFontSizes()
    }
    
    private func setAllDigitButtonsRounded(){
        for button in digitButtons{
            button.roundedBorder = true
        }
    }
    
    private func refreshDigitButtonsFontSizes(){
        let buttonWidth = digitButtons[0].frame.size.width
        let newFontSize = buttonWidth * Constants.DigitButtonWidthToTitleFontSizeRatio
        for button in digitButtons{
            button.titleLabel?.font = UIFont.systemFontOfSize(newFontSize, weight: UIFontWeightThin)
        }
        println("Digit buttons font size: \(digitButtons[0].titleLabel?.font?.pointSize)")
        println("Digit buttons width: \(buttonWidth)")
    }
    
    override func viewDidDisappear(animated: Bool) {
        AppDelegate.restrictRotation = false
    }
}

