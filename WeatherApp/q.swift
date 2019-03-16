//
//  ViewController.swift
//  WeatherApp
//
//  Created by ZHU YUNJIAO on 4/12/18.
//  Copyright © 2018 ZHU YUNJIAO. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import ObjectMapper_Realm

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultsTableView: UITableView!
    var cities :[City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.delegate = self
        self.resultsTableView.delegate = self
        self.resultsTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MyResultTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if nil == cell {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellIdentifier)
            cell?.backgroundColor = UIColor.clear
        }
//        let cityName = cities[indexPath.row]["name"] as? String
//        if self.cities?.count ?? <#default value#> > 0 {
            let city = self.cities[indexPath.row]
            
            cell?.textLabel!.text = city.name
//        }
        
       
//        cell?.textLabel?.font = UIFont.systemFontOfSize(20.0)
//        cell?.textLabel?.textColor = UIColor.whiteColor
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = self.cities[indexPath.row]
        var cityname = city.name
        let seperate = cityname.split(separator: ",")
        cityname = String(seperate[0])
        print("get first name --- \(cityname)")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "weather_detail_view_controller") as! WeatherDetailViewController
        vc.selectedCity = cityname
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if 0 < string.count {
            print("text 0000")
            let cityName = textField.text?.appendingFormat(string)
            self.didGetAutocompleteCityName(cityName: cityName!)
            //            WAUpdater.sharedInstance().didGetAutocompleteCityName(cityName!)
        } else if 1 < (textField.text?.count)! {
            print("text 1111")
            //            WAUpdater.sharedInstance().didGetAutocompleteCityName(textField.text!)
        }
        return true
    }
    
    
    func didGetAutocompleteCityName(cityName: String) {
//        c98171fdab82c53c09a3492b6d706aca ----- API KEY
        let getcities: String = "http://api.apixu.com/v1/search.json?key=c98f4309db80498284033250180912&q=" + cityName
        print("uuuurl ---- \(getcities)")
        
        Alamofire.request(getcities)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    // handle failure
                    return
                }
                
                
                // make sure we got some JSON since that's what we expect
                guard (response.result.value as? [Any]) != nil else {
                    print("didn't get todo object as JSON from API")
//                    print("Error: \(response.result.error)")
                    return
                }
                
                // handle success
                let resultss = response.result.value as? [Any]
                print(resultss as Any)
                
                
                self.cities = Mapper<City>().mapArray(JSONArray: response.value as! [[String : Any]])
                
                self.resultsTableView.reloadData()
               print("mapper city --- \(self.cities)")
                
        }
        
    }
        

        
        /////
        
        /*
        let todoEndpoint: String = "http://api.apixu.com/v1/current.json?key=c98f4309db80498284033250180912&q=" + cityName
        print("uuuurl ---- \(todoEndpoint)")
        
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

                // handle success
                let resultss = response.result.value as? [String: Any]
                print(resultss)
        }

    }
    
    *///////////
    
                
//        Alamofire.request(
//            .GET,
//            todoEndpoint,
//            parameters: ["query": cityName],
//            encoding: ParameterEncoding.URLEncodedInURL,
//            headers: nil)
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .Success:
//                    if let JSON = response.result.value as? [String: AnyObject] {
//                        if let cities = JSON["RESULTS"] as? [[String: AnyObject]] {
//
//                            self.searchTextField.text = cities
////                            NSNotificationCenter.defaultCenter().postNotificationName("didGetAutocompleteCityName",
////                                                                                      object: nil,
////                                                                                      userInfo: ["result": "success", "cities": cities])
//                        }
//                    }
//                case .Failure(let error):
//                    print("Get Autocomplete city name failure: \(error.localizedDescription)")
//                    NSNotificationCenter.defaultCenter().postNotificationName("didGetAutocompleteCityName",
//                                                                              object: nil,
//                                                                              userInfo: ["result": "failure"])
//                }
//        }
//    }

}

