//
//  PIN.swift
//  PINKeeper
//
//  Created by Alexey Tsymlov on 8/19/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import Foundation
import CoreData

@objc(PIN)
class PIN: NSManagedObject {
    @NSManaged var desc: String!
    @NSManaged var value: String!
}
