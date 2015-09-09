//
//  MainNavigationController.swift
//  PINKeeper
//
//  Created by Alexey Tsymlov on 9/8/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        addObserverForRisigningActiveEvent()
        addObserverForLaunchingEvent()
    }
    
    private func addObserverForRisigningActiveEvent(){
        let center = NSNotificationCenter.defaultCenter()
        center.addObserverForName(UIApplicationWillResignActiveNotification, object: UIApplication.sharedApplication(), queue: NSOperationQueue.mainQueue()){ notification in
            println("App will enter foreground!!!!")
            self.showAuthenticationViewController()
        }
    }
    
    private func showAuthenticationViewController(){
        let authVC = storyboard?.instantiateViewControllerWithIdentifier("AuthenticationViewController") as! AuthenticationViewController
        presentViewController(authVC, animated: false, completion: nil)
    }
    
    private func addObserverForLaunchingEvent(){
        let center = NSNotificationCenter.defaultCenter()
        center.addObserverForName(UIApplicationDidFinishLaunchingNotification, object: UIApplication.sharedApplication(), queue: NSOperationQueue.mainQueue()){ notification in
            println("App is launching!!!!")
            self.showAuthenticationViewController()
        }
    }
}
