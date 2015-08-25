//
//  Settings.swift
//  PINKeeper
//
//  Created by Alexey Tsymlov on 8/13/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import Foundation

class Settings {
    
    private struct Constants {
        struct UserDefaultsKeys {
            static let isTouchIDBlockedKey = "com.alexeytsymlov.PINKeeper.Settings.isTouchIDBlocked"
        }
    }
    
    private static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    class var isTouchIDBlocked: Bool{
        set{
            userDefaults.setBool(newValue, forKey: Constants.UserDefaultsKeys.isTouchIDBlockedKey)
            if !userDefaults.synchronize(){ println("UserDefaults synchronization failed!") }
        }
        get{
            return userDefaults.boolForKey(Constants.UserDefaultsKeys.isTouchIDBlockedKey)
        }
    }
}