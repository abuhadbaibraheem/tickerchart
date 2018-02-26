//
//  General.swift
//  tickerchart
//
//  Created by Heema Boss on 2/26/18.
//  Copyright © 2018 Heema Boss. All rights reserved.
//

import Foundation
import ObjectMapper
class General: Mappable {
    var name = ""
    var trades = 1
    var volume = 1
    var amount = 1
   var companies1 = companies()
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        name   <- map["name"]
        trades   <- map["trades"]
        volume   <- map["volume"]
        amount   <- map["amount"]
        companies1  <- map["companies"]
       
    }
}

class companies: Mappable {
    var winning = 1
    var fixed = 1
    var losing = 1
  
    
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        winning   <- map["winning"]
        fixed   <- map["fixed"]
        losing   <- map["losing"]
     
        
    }
}
