//
//  City.swift
//  WeatherApp
//
//  Created by ZHU YUNJIAO on 9/12/18.
//  Copyright © 2018 ZHU YUNJIAO. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class City: Object, Mappable {
    
    @objc dynamic var cityId = ""
    @objc dynamic var country = ""
    @objc dynamic var name = ""
    @objc dynamic var region = ""
    @objc dynamic var url = ""
   
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        cityId <- map["id"]
        country <- map["country"]
        name <- map["name"]
        region <- map["region"]
        url <- map["url"]
    }
}
