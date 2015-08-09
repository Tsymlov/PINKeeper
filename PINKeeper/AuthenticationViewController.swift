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
    
    let context = LAContext()

    override func viewDidLoad() {
        super.viewDidLoad()
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
}

