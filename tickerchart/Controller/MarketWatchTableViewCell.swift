//
//  MarketWatchTableViewCell.swift
//  tickerchart
//
//  Created by Heema Boss on 2/26/18.
//  Copyright © 2018 Heema Boss. All rights reserved.
//

import UIKit

class MarketWatchTableViewCell: UITableViewCell {

  
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Ask_Price: UILabel!
    @IBOutlet weak var Last_Price: UILabel!
    @IBOutlet weak var Bid_Price: UILabel!
    @IBOutlet weak var High_Price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
