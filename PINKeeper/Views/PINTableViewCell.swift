//
//  PINTableViewCell.swift
//  PINKeeper
//
//  Created by Alexey Tsymlov on 8/13/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit

class PINTableViewCell: UITableViewCell {

    static let reuseID = "PINTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            refreshUI()
        }
    }
    @IBOutlet weak var pinLabel: UILabel!{
        didSet{
            refreshUI()
        }
    }
    
    var pin: PIN?{
        didSet{
            refreshUI()
        }
    }
    
    private func refreshUI(){
        titleLabel?.text = pin?.desc
        pinLabel?.text = pin?.value
    }

    override func prepareForReuse() {
        titleLabel.text = ""
        pinLabel.text = ""
    }
}
