//
//  WeatherIconProvider.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 9/11/23.
//

import Foundation

class WeatherIconProvider{
    static let shared = WeatherIconProvider()
    var conditions : [Condition] = []
    let filename = "conditions"
    private init(){
        loadConditionsFromJSON()
    }
    
    func iconSF(forConditionCode code: Int) -> String {
        var iconSF = "?"
        for condition in conditions {
            if condition.code == code{
                iconSF = sfSymbolName(forIconCode: condition.icon)
                break
            }
        }
        return iconSF
    }
    
    func loadConditionsFromJSON(){
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json")
        else {
            print("Failed to locate \(filename).json in bundle.")
                        return
        }
        do{
            let data = try Data(contentsOf: url)
            self.conditions = try JSONDecoder().decode([Condition].self, from: data)
//            print(conditions)
        } catch {
            print("An error occurred: \(error.localizedDescription)")
        }
    }
    
    func sfSymbolName(forIconCode iconCode: Int) -> String {
        switch iconCode {
        case 113:
            return "sun.max"
        case 116:
            return "cloud.sun"
        case 119:
            return "cloud"
        case 122:
            return "cloud.fill"
        case 143:
            return "cloud.fog"
        case 176:
            return "cloud.drizzle"
        case 179:
            return "snow"
        case 182:
            return "cloud.sleet"
        case 185:
            return "cloud.drizzle"
        case 200:
            return "cloud.bolt.rain"
        case 227:
            return "wind.snow"
        case 230:
            return "wind.snow"
        case 248:
            return "cloud.fog"
        case 260:
            return "cloud.fog"
        case 263, 266:
            return "cloud.drizzle"
        case 281, 284:
            return "cloud.sleet"
        case 293, 296, 299, 302, 305, 308:
            return "cloud.rain"
        case 311, 314:
            return "cloud.sleet"
        case 317, 320:
            return "cloud.sleet"
        case 323, 326, 329, 332, 335, 338:
            return "cloud.snow"
        case 350:
            return "cloud.sleet"
        case 353, 356, 359:
            return "cloud.rain"
        case 362, 365:
            return "cloud.sleet"
        case 368, 371:
            return "cloud.snow"
        case 374, 377:
            return "cloud.hail"
        case 386, 389:
            return "cloud.bolt.rain"
        case 392, 395:
            return "cloud.snow.bolt"
        default:
            return "questionmark" // Default SF Symbol for unidentified icon codes.
        }
    }

    struct Condition: Decodable{
        let code: Int
        let day: String
        let night: String
        let icon: Int
    }
}
