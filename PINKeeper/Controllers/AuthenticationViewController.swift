//
//  ViewController.swift
//  PINKeeper
//
//  Created by Alexey Tsymlov on 8/9/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit
import LocalAuthentication
import AudioToolbox
import UIView_Shake

class AuthenticationViewController: UIViewController {
    
    struct Constants {
        static let DigitButtonWidthToTitleFontSizeRatio: CGFloat = 0.45
        struct Progress {
            static let progressColor = UIColor.lightGrayColor()
            struct Shaking {
                static let speed: NSTimeInterval = 0.1
                static let delta: CGFloat = 50
                static let times: Int32 = 6
            }
        }
    }
    
    // MARK: - Properties
    
    @IBOutlet var digitButtons: [UIButton]!
    @IBOutlet weak var progress1View: UIView!
    @IBOutlet weak var progress2View: UIView!
    @IBOutlet weak var progress3View: UIView!
    @IBOutlet weak var progress4View: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    private let showPINsSegueID = "Show PINs"
    private let context = LAContext()
    
    private var progressViews: [UIView]{
        return [progress1View, progress2View, progress3View, progress4View]
    }
    
    private var passCode = ""{
        didSet{
            if passCode == "" {
                enterProgress = 0
            }
        }
    }
    
    private var enterProgress = 0 { //from 0 to 4
        didSet{
            enterProgress = min(max(enterProgress, 0), 4)
            refreshProgressViews()
            deleteButton?.hidden = enterProgress == 0
        }
    }
    
    private func refreshProgressViews(){
        for (index, progressView) in enumerate(progressViews){
            if (index+1) <= enterProgress {
                switchOn(progressView)
            }else{
                switchOff(progressView)
            }
        }
    }
    
    private func switchOn(progressView: UIView){
        progressView.backgroundColor = Constants.Progress.progressColor
    }
    
    private func switchOff(progressView: UIView){
        progressView.backgroundColor = UIColor.clearColor()
    }
    
    private var isEnterEnded: Bool{
        return enterProgress == 4
    }
    
    // MARK: - ViewController life cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        passCode = ""
        restrictRotationForiPhones()
    }
    
    private func restrictRotationForiPhones(){
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            AppDelegate.restrictRotation = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
        setAllProgressViewRounded()
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
    
    private func setAllProgressViewRounded(){
        for view in progressViews{
            view.roundedBorder = true
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        AppDelegate.restrictRotation = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - Actions
    
    @IBAction func digitButtonTapped(sender: UIButton) {
        ++enterProgress
        passCode += sender.titleLabel?.text ?? ""
        if isEnterEnded {
            checkPasscode()
        }
    }
    
    private func checkPasscode(){
        if Authentication.checkPasscode(passCode){
            println("Enter passcode: Success.")
            goToPINs()
        }else{
            println("Enter passcode: Failed!")
            vibrate()
            shakeProgressViews()
            passCode = ""
        }
    }
    
    private func goToPINs(){
        performSegueWithIdentifier(showPINsSegueID, sender: self)
    }
    
    private func vibrate(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    private func shakeProgressViews(){
        let times = Constants.Progress.Shaking.times
        let delta = Constants.Progress.Shaking.delta
        let speed = Constants.Progress.Shaking.speed
        for view in progressViews{
            view.shake(times, withDelta: delta, speed: speed)
        }
    }
    
    @IBAction func deleteTapped(sender: UIButton) {
        --enterProgress
        removeLastCharInPassCode()
    }
    
    private func removeLastCharInPassCode(){
        passCode.removeAtIndex(passCode.endIndex.predecessor())
    }

}

