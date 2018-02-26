//
//  Marketwatch.swift
//  tickerchart
//
//  Created by Heema Boss on 2/26/18.
//  Copyright © 2018 Heema Boss. All rights reserved.
//

import Foundation
import ObjectMapper

class Marketwatch: Mappable {
    var name = ""
    var ask_price = 1.0
    var last_price = 1.0
    var bid_price = 1.0
    var high_price = 1.0
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        name   <- map["name"]
        ask_price   <- map["ask-price"]
        last_price   <- map["last-price"]
        bid_price   <- map["bid-price"]
        high_price   <- map["high-price"]
        
    }
}
