//
//  WetherLoader.swift
//  Wether
//
//  Created by  Виктор Борисович on 10.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import Alamofire

class WetherLoader {
    func loadData(callBack: @escaping (WeatherResponseObject) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=Moscow,ru&units=metric&APPID=fc0ec4e3109e9d8ff3f1a8144f08b326")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { responseData, response, error in
            if let data = responseData {
                print("response come")
                
                let decoder = JSONDecoder()
                
                if let weatherresponseObject = try? decoder.decode(WeatherResponseObject.self, from: data) {
                    DispatchQueue.main.async {
                        print("callBack call")
                        callBack(weatherresponseObject)
                    }
                } else {
                    print("parse error")
                }
            }
        }
        
        task.resume()
    }
    
    func loadDataViaAlamofire(callBack: @escaping (WeatherResponseObject) -> Void) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?q=Moscow,ru&units=metric&APPID=fc0ec4e3109e9d8ff3f1a8144f08b326")
            .responseJSON(completionHandler: {
                responseData in
                    if let data = responseData.data {
                        //let data = objects as? NSDictionary {
                        print("response come")
        
                        let decoder = JSONDecoder()
        
                        if let weatherresponseObject = try? decoder.decode(WeatherResponseObject.self, from: data) {
                            DispatchQueue.main.async {
                                print("callBack call")
                                callBack(weatherresponseObject)
                            }
                        } else {
                            print("parse error")
                        }
                    }
            }
        )
    }
}
