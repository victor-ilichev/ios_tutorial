//
//  StandartWayViewController.swift
//  Wether
//
//  Created by  Виктор Борисович on 10.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class StandartWayViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    let weatherCellIdentifier = "WeatherCell"
    var weatherList: [DayWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loader = WetherLoader()
        loader.loadData(callBack: {response in
            print("status: \(response.cod) count: \(response.list.count)")
            self.weatherList = response.list
            self.mainTableView.reloadData()
        })
    }
    

}

extension StandartWayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: weatherCellIdentifier) as! DayWeatherTableViewCell
        cell.clearRows()
        
        let currentDay = weatherList[indexPath.row]
        cell.someLabel.text = "\(currentDay.dt_txt)"
        
        cell.addRow(leftColumnText: "Temperature", rightColumnText: "\(currentDay.main.temp)")
        cell.addRow(leftColumnText: "Wind", rightColumnText: "speed: \(currentDay.wind.speed)")
        cell.addRow(leftColumnText: "Cloudiness", rightColumnText: "\(currentDay.clouds.all)")
        cell.addRow(leftColumnText: "Pressure", rightColumnText: "\(currentDay.main.pressure)")
        cell.addRow(leftColumnText: "Humidity", rightColumnText: "\(currentDay.main.humidity)")
        
        if currentDay.weather.count > 0 {
            cell.addRow(leftColumnText: "Main", rightColumnText: "\(currentDay.weather[0].main)")
            cell.addRow(leftColumnText: "Description", rightColumnText: "\(currentDay.weather[0].description)")
        }
        
        return cell
    }
}
