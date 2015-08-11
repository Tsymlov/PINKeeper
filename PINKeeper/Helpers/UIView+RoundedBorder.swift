//
//  UIButton+RoundedBorder.swift
//  App4Brand
//
//  Created by Alexey Tsymlov on 7/25/15.
//  Copyright (c) 2015 App4Brand. All rights reserved.
//

import UIKit

extension UIView{
    /// If value is true the UIView has a rounded border with 1 point of width.
    /// Color of the border is equal to the tint color of the UIView.
    var roundedBorder: Bool{
        set(isRoundedBorder){
            if isRoundedBorder{
                self.layer.borderWidth = 1.0
                self.layer.borderColor = self.tintColor?.CGColor
                self.layer.cornerRadius = self.frame.size.height / 2
                self.layer.masksToBounds = true
            }else{
                self.layer.borderWidth = 0.0
                self.layer.borderColor = nil
                self.layer.cornerRadius = 0.0
                self.layer.masksToBounds = false
            }
        }
        get{
            return self.layer.masksToBounds && self.layer.borderWidth == self.frame.size.height / 2
        }
    }
}
