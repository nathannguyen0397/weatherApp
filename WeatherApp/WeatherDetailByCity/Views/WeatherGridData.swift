//
//  WeatherGridData.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/15/23.
//

import Foundation

struct WeatherConditionIndex: Identifiable {
    var id = UUID()
    let condition: String
    let image: String
    let index: String
    let description: String
    
    static let mockData = [
        WeatherConditionIndex(condition: "UV INDEX",image: "sun.max.fill",  index: "", description: ""),
        WeatherConditionIndex(condition: "SUNSET",image: "sunset.fill",  index: "", description: ""),
        WeatherConditionIndex(condition: "WIND",image: "wind",  index: "8", description: ""),
        WeatherConditionIndex(condition: "RAINFALL",image: "drop.fill",  index: "0\" \nin last 24 hrs", description: "None expected in next 10 days"),
        WeatherConditionIndex(condition: "FEELS LIKE",image: "thermometer.sun",  index: "71°", description: "Similar to the actual temperature."),
        WeatherConditionIndex(condition: "HUMIDITY",image: "humidity",  index: "45%", description: "The dew point is 47° right now."),
        WeatherConditionIndex(condition: "VISIBILITY",image: "eye.fill",  index: "10 mi", description: "It's perfectly clear."),
        WeatherConditionIndex(condition: "PRESSURE", image: "lifepreserver", index: "29.95", description: ""),

    ]
}
