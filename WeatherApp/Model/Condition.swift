//
//  Condition.swift
//  WeatherApp
//
//  Created by ZHU YUNJIAO on 16/12/18.
//  Copyright © 2018 ZHU YUNJIAO. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class Condition: Object, Mappable {
    
    @objc dynamic var icon = ""
    @objc dynamic var text = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        icon <- map["icon"]
        text <- map["text"]
    }
}

