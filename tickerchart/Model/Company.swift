//
//  Company.swift
//  tickerchart
//
//  Created by Heema Boss on 2/26/18.
//  Copyright © 2018 Heema Boss. All rights reserved.
//

import Foundation
import ObjectMapper

class Company: Mappable {
    var company_name = ""
    var symbol = 1
    var trades_count = 1
    var high = 1
    var low = 1
    var volume = 1
    var amount = 1
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        company_name   <- map["company-name"]
        symbol   <- map["symbol"]
        trades_count   <- map["trades-count"]
        high   <- map["high"]
        low   <- map["low"]
        volume   <- map["volume"]
        amount   <- map["amount"]
        
    }
}
