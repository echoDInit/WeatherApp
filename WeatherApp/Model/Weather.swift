//
//  Weather.swift
//  WeatherApp
//
//  Created by ZHU YUNJIAO on 16/12/18.
//  Copyright © 2018 ZHU YUNJIAO. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class Weather: Object, Mappable {
    
    @objc dynamic var tempF = ""
    @objc dynamic var tempC = ""
    @objc dynamic var condition : Condition? = Condition()
    @objc dynamic var humidity = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        tempC <- map["temp_c"]
        tempF <- map["temp_f"]
        condition <- map["condition"]
        humidity <- map["humidity"]
    }
}

