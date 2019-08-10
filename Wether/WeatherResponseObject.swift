//
//  WeatherResponseObject.swift
//  Wether
//
//  Created by  Виктор Борисович on 10.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

struct WeatherResponseObject: Decodable {
    let cod: String
    let message: CGFloat
    let cnt: Int
    let list: [DayWeather]
}

struct DayWeather: Decodable {
    let dt: Int
    let main: TemperatureEntity
    let weather: [WetherEntity]
    let dt_txt: String
    let clouds: Clouds
    let wind: Wind
}

struct TemperatureEntity: Decodable {
    let temp: CGFloat
    let temp_min: CGFloat
    let temp_max: CGFloat
    let pressure: CGFloat
    let sea_level: CGFloat
    let grnd_level: CGFloat
    let humidity: CGFloat
    let temp_kf: CGFloat
}

struct WetherEntity: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Decodable {
    let all: Int
}

struct Wind: Decodable {
    let speed: CGFloat
    let deg: CGFloat
}
