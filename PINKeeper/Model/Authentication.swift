//
//  Authentication.swift
//  PINKeeper
//
//  Created by Alexey Tsymlov on 8/12/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import Foundation

class Authentication{
    class func checkPasscode(passCode: String)->Bool{
        return passCode == "0000"
    }
}