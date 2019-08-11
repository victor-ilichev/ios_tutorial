//
//  StandartWayViewController.swift
//  Wether
//
//  Created by  Виктор Борисович on 10.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import RealmSwift

class WeatherEntity: Object {
    @objc dynamic var dt_txt = ""
    @objc dynamic var temperature = ""
    @objc dynamic var wind = ""
    @objc dynamic var cloudiness = ""
    @objc dynamic var pressure = ""
    @objc dynamic var humidity = ""
    @objc dynamic var weather_main = ""
    @objc dynamic var weather_description = ""
}

class StandartWayViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    let weatherCellIdentifier = "WeatherCell"
    var weatherList: [DayWeather] = []
    var weatherEntityList: [WeatherEntity] = []
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let allStoredWeather = self.realm.objects(WeatherEntity.self)
        
        for we in allStoredWeather {
            weatherEntityList.append(we)
        }
        
        let loader = WetherLoader()
        
        loader.loadData(callBack: {response in
            print("status: \(response.cod) count: \(response.list.count)")
            
            if response.list.count > 0 {
                
                // truncate WeatherEntity s
                try! self.realm.write {
                    self.weatherEntityList = []
                    self.realm.delete(self.realm.objects(WeatherEntity.self))
                }
                
                for responsData in response.list {
                    let weather = mapWeatherEntityWithCurrentDay(currentDay: responsData)
                    self.weatherEntityList.append(weather)
                    
                    // add new rows to realm
                    try! self.realm.write {
                        self.realm.add(weather)
                    }
                }
            }
            
            self.mainTableView.reloadData()
        })
    }
}

func mapWeatherEntityWithCurrentDay(currentDay: DayWeather) -> WeatherEntity {
    let entity = WeatherEntity()
    
    entity.dt_txt = "\(currentDay.dt_txt)"
    entity.temperature = "\(currentDay.main.temp)"
    entity.wind = "\(currentDay.wind.speed)"
    entity.cloudiness = "\(currentDay.clouds.all)"
    entity.pressure = "\(currentDay.main.pressure)"
    entity.humidity = "\(currentDay.main.humidity)"
    
    if currentDay.weather.count > 0 {
        entity.weather_main = "\(currentDay.weather[0].main)"
        entity.weather_description = "\(currentDay.weather[0].description)"
    }
    
    return entity
}

extension StandartWayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherEntityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: weatherCellIdentifier) as! DayWeatherTableViewCell
        cell.clearRows()
        
        let weatherEntity = weatherEntityList[indexPath.row]
//        let weatherEntity = mapWeatherEntityWithCurrentDay(currentDay: currentDay)
        
        cell.someLabel.text = weatherEntity.dt_txt

        cell.addRow(leftColumnText: "Temperature", rightColumnText: weatherEntity.temperature)
        cell.addRow(leftColumnText: "Wind", rightColumnText: "speed: \(weatherEntity.wind)")
        cell.addRow(leftColumnText: "Cloudiness", rightColumnText: weatherEntity.cloudiness)
        cell.addRow(leftColumnText: "Pressure", rightColumnText: weatherEntity.pressure)
        cell.addRow(leftColumnText: "Humidity", rightColumnText: weatherEntity.humidity)
        cell.addRow(leftColumnText: "Main", rightColumnText: weatherEntity.weather_main)
        cell.addRow(leftColumnText: "Description", rightColumnText: weatherEntity.weather_description)
        
//        cell.someLabel.text = "\(currentDay.dt_txt)"
//
//        cell.addRow(leftColumnText: "Temperature", rightColumnText: "\(currentDay.main.temp)")
//        cell.addRow(leftColumnText: "Wind", rightColumnText: "speed: \(currentDay.wind.speed)")
//        cell.addRow(leftColumnText: "Cloudiness", rightColumnText: "\(currentDay.clouds.all)")
//        cell.addRow(leftColumnText: "Pressure", rightColumnText: "\(currentDay.main.pressure)")
//        cell.addRow(leftColumnText: "Humidity", rightColumnText: "\(currentDay.main.humidity)")
//
//        if currentDay.weather.count > 0 {
//            cell.addRow(leftColumnText: "Main", rightColumnText: "\(currentDay.weather[0].main)")
//            cell.addRow(leftColumnText: "Description", rightColumnText: "\(currentDay.weather[0].description)")
//        }
        
        return cell
    }
}
