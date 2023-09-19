//
//  ModelWeather.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 9/1/23.
//

import Foundation
import SwiftUI

struct Constant{
    /*Open Source: https://www.weatherapi.com/docs */
    static let weatherApiBaseUrl = "https://api.weatherapi.com/v1/forecast.json?"
    static let weatherApiKey = "0c4ec068fc9f4efea8800200230209"
    
    /*
     Example Valid full URL
     https://api.weatherapi.com/v1/forecast.json?key=0c4ec068fc9f4efea8800200230209&q=San%20Jose&days=3&aqi=no&alerts=no

     //Example Valid URL with free plan in San Jose, CA
     https://api.weatherapi.com/v1/forecast.json?key=0c4ec068fc9f4efea8800200230209&q=37.34,-121.89

     Doccumentation on request parameters
     https://www.weatherapi.com/docs/#intro-request
     */
    
}

struct WeatherApiInfo: Identifiable {
    let id = UUID()
    var city = ""
    var tempNow = ""
    var temHigh = ""
    var temLow = ""
    var lon = ""
    var lat = ""
    var timeLocal = ""
    var condition = ""
    var iconUrl = ""
    var iconSF = ""
    var hourlyInfo = [HourlyTimeTempIcon]()
    
    var model: WeatherApiResponse
    
    init(model: WeatherApiResponse) {
        self.model = model
        setCity()
        setTempCurr()
        setTempHigh()
        setTempLow()
        setLon()
        setLat()
        setTime()
        setCondition()
        setIconUrl()
        setHourlyInfo()
    }
}


struct WeatherApiResponse: Codable, Identifiable{
    let id = UUID()
    let location: LocationWeatherApi
    let current: CurrentWeatherApi
    let forecast: Forecast
}

struct LocationWeatherApi: Codable{
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime_epoch: Int
}

struct CurrentWeatherApi: Codable{
    let temp_c: Double
    let temp_f: Double
}

struct Forecast: Codable{
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable, Identifiable{
    let id = UUID()
    let date: String
    let day: DailyWeather
    let astro: Astro
    let hour: [HourlyWeather]
}

struct DailyWeather: Codable{
    let mintemp_f: Double
    let maxtemp_f: Double
    let condition: Condition
}

struct Astro: Codable{
    let sunrise: String
    let sunset: String
}

struct HourlyWeather: Codable, Identifiable{
    let id = UUID()
    let time_epoch: Int
    let temp_f: Double
    let condition: Condition
}

struct Condition: Codable{
    let text: String
    let icon: String
    let code: Int
}

struct HourlyTimeTempIcon{
    let time: String
    let temp: String
    let iconUrl: String
    let iconSF: String
}

extension WeatherApiInfo{
    mutating func setCity() {
        // Set city value from model
        self.city = model.location.name
    }
    
    mutating func setTempCurr() {
        // Set tempCurr value from model
        let tempCurr = Int(ceil(model.current.temp_f))
        self.tempNow = "\(String(tempCurr))°"
    }
    
    mutating func setTempHigh() {
        // Set temHigh value from model
        let temp = Int(ceil((model.forecast.forecastday.first?.day.maxtemp_f)!))
        self.temHigh = "\(String(temp))°"
    }
    
    mutating func setTempLow() {
        // Set temLow value from model
        let temp = Int(ceil((model.forecast.forecastday.first?.day.mintemp_f)!))
        self.temLow = "\(String(temp))°"

    }
    
    mutating func setLon() {
        // Set lon value from model
        self.lon = String(model.location.lon)
    }
    
    mutating func setLat() {
        // Set lat value from model
        self.lat = String(model.location.lat)
    }
    
    mutating func setTime() {
        // Set time value from model
        self.timeLocal = timeEpochFormatter(timeEpoch: model.location.localtime_epoch, dateFormat: "hh:mm a")
    }
    
    mutating func setCondition(){
        self.condition = (model.forecast.forecastday.first?.day.condition.text)!
    }
    
    mutating func setIconUrl(){
        self.iconUrl = "https:" + (model.forecast.forecastday.first?.day.condition.icon)!
    }
    
//    mutating func iconSF(){
//        WeatherIconProvider.shared.iconSF(forConditionCode: model.forecast.forecastday.first?.day.condition.code)
//    }
    
    mutating func setHourlyInfo(){
        let nowEpoch = model.location.localtime_epoch
        let oneDayLateEpoch = nowEpoch + 86400 // 86400 seconds = 24 hours
        //Add initial condition (now)
        self.hourlyInfo.append(HourlyTimeTempIcon(time: "Now", temp: self.tempNow, iconUrl: self.iconUrl, iconSF: "?"))
        
        //Traverse list of days
        for forcastDay in model.forecast.forecastday{
            //travese list of hours
            for hour in forcastDay.hour{
                if nowEpoch < hour.time_epoch && hour.time_epoch < oneDayLateEpoch{
                    let time = timeEpochFormatter(timeEpoch: hour.time_epoch, dateFormat: "hha")
                    let temp = String(Int(ceil(hour.temp_f))) + "°"
                    let iconUrl = "https:" + hour.condition.icon
                    let iconSF = WeatherIconProvider.shared.iconSF(forConditionCode: hour.condition.code)
                    self.hourlyInfo.append(HourlyTimeTempIcon(time: time, temp: temp, iconUrl: iconUrl, iconSF: iconSF))
                    //print(WeatherIconProvider.shared.iconSF(forConditionCode: hour.condition.code))
                }
            }
        }
        
        func epochToHourAmPm(timeEpoch: Int) -> String{
            return ""
        }
    }
    
    func timeEpochFormatter(timeEpoch: Int, dateFormat: String) -> String{
        let date = Date(timeIntervalSince1970: Double(timeEpoch))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        var hourMinuteAmPm = dateFormatter.string(from: date)

        let firstCharacter = hourMinuteAmPm[hourMinuteAmPm.startIndex]
        if(firstCharacter == "0"){
            hourMinuteAmPm.remove(at: hourMinuteAmPm.startIndex)
        }
        return hourMinuteAmPm
    }
}


