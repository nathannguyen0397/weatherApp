//
//  WeatherData.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/14/23.
//

import Foundation

struct HourlyData: Identifiable {
    var id = UUID()
    let image: String
    let temperature: String
    let time: String
    
    static let mockData = [
        HourlyData(image: "cloud.drizzle.fill", temperature: "54°", time: "NOW"),
        HourlyData(image: "sun.haze.circle", temperature: "57°", time: "10AM"),
        HourlyData(image: "sun.max.fill", temperature: "60°", time: "11AM"),
        HourlyData(image: "cloud.drizzle.fill", temperature: "61°", time: "12PM"),
        HourlyData(image: "sun.max.fill", temperature: "62°", time: "1PM"),
        HourlyData(image: "sun.max.fill", temperature: "64°", time: "2PM"),
        HourlyData(image: "sun.max.fill", temperature: "65°", time: "3PM"),
        HourlyData(image: "sun.max.fill", temperature: "66°", time: "4PM"),
    ]
}

struct DayData: Identifiable {
    var id = UUID()
    let day: String
    let image: String
    let highTemp: String
    let lowTemp: String
    
    static let mockData = [
        DayData(day: "Today", image: "sun.max.fill", highTemp: "57", lowTemp: "43"),
        DayData(day: "Tue", image: "cloud.sun.fill", highTemp: "78", lowTemp: "58"),
        DayData(day: "Wed", image: "sun.max.fill", highTemp: "80", lowTemp: "60"),
        DayData(day: "Thu", image: "sun.haze.circle", highTemp: "79", lowTemp: "63"),
        DayData(day: "Fri", image: "cloud.sun.rain.fill", highTemp: "75", lowTemp: "54"),
        DayData(day: "Sat", image: "cloud.sun.fill", highTemp: "77", lowTemp: "53"),
        DayData(day: "Sun", image: "sun.max.fill", highTemp: "76", lowTemp: "50"),
        DayData(day: "Mon", image: "sun.max.fill", highTemp: "80", lowTemp: "57"),
        DayData(day: "Tue", image: "sun.haze.circle", highTemp: "82", lowTemp: "59"),
        DayData(day: "Wed", image: "cloud.sun.fill", highTemp: "83", lowTemp: "61"),
        DayData(day: "Thu", image: "cloud.sun.fill", highTemp: "81", lowTemp: "65")
    ]
}




