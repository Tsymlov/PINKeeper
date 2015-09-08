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
        addObserverForForegroundEvent()
    }
    
    private func addObserverForForegroundEvent(){
        let center = NSNotificationCenter.defaultCenter()
        center.addObserverForName(UIApplicationWillEnterForegroundNotification, object: UIApplication.sharedApplication(), queue: NSOperationQueue.mainQueue()){ notification in
            println("App will enter foreground!!!!")
        }
    }
}
