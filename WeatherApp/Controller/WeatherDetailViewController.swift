//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by ZHU YUNJIAO on 9/12/18.
//  Copyright © 2018 ZHU YUNJIAO. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import ObjectMapper_Realm

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var weaImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var watherNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var selectedCity : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.searchWeather(cityName: self.selectedCity)
        
    }
    
    func searchWeather(cityName:String) {
        
         let todoEndpoint: String = "http://api.apixu.com/v1/current.json?key=c98f4309db80498284033250180912&q=" + cityName
         print("detail url ---- \(todoEndpoint)")
         
         Alamofire.request(todoEndpoint)
         .responseJSON { response in
         guard response.result.isSuccess else {
         // handle failure
         return
         }
         
         
         // make sure we got some JSON since that's what we expect
         guard let json = response.result.value as? [String: Any] else {
         print("didn't get todo object as JSON from API")
         print("Error: \(response.result.error)")
         return
         }
            
            
            var veather = Mapper<Weather>().map(JSONObject: response.value as! Any)
             print("vveather ---- \(veather)")
            
            
            
            
//            var wather = Mapper<Weather>().mapArray(JSONArray: response.value as! [[String : Any]])
//            
//            print("waeether ---- \(wather)")
            
         
         // handle success
         let resultss = response.result.value as? [String: Any]
            print("dddetailll----")
            print(resultss)
         }
        
        
        
        
        
        
//        let weather = Mapper<Weather>().map(JSON: response.value as! [String : Any])
        
//        print("wwweather --- \(weather)")
        
    }
    

}
