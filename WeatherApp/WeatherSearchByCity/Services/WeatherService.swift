//
//  WeatherServices.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 6/28/23.
//

import Foundation

//var URL: String = https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
//var URL: String = https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
//API Key: 5a5c9776c4bcddfb6e041a2505b9b9c6
//http://api.openweathermap.org/geo/1.0/direct?q=San Jose,,US,&limit=1&appid=5a5c9776c4bcddfb6e041a2505b9b9c6
//https://api.openweathermap.org/data/2.5/weather?q=San Jose&appid=5a5c9776c4bcddfb6e041a2505b9b9c6
//https://api.openweathermap.org/data/2.5/weather?lat=37.3394&lon=-121.895&appid=5a5c9776c4bcddfb6e041a2505b9b9c6

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case emptyData
    case serviceUnavailable
    case decodingError
        
    var description: String {
        switch self {
        case .invalidUrl:
            return "invalid url"
        case .invalidResponse:
            return "invalid response"
        case .emptyData:
            return "empty data"
        case .serviceUnavailable:
            return "service unavailable"
        case .decodingError:
            return "decoding error"
        }
    }
}
protocol WeatherServiceProtocol {
    func fetchWeather(city: String) async throws -> [Location]
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse
}

class WeatherService : WeatherServiceProtocol{
    struct Constants {
        static let dateURL = "https://api.openweathermap.org/data/2.5/weather"
        static let geoURL = "https://api.openweathermap.org/geo/1.0/direct"
        static let apiKey = "5a5c9776c4bcddfb6e041a2505b9b9c6"
    }
    
    //Fetch weather using Citi name
    func fetchWeather(city: String) async throws -> [Location] {
//        let mock = "San Jose"
//        let encodedCity = mock.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "\(Constants.geoURL)?q=\(encodedCity),,US&limit=1&appid=\(Constants.apiKey)") else { throw NetworkError.invalidUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            // Handle error status codes from the server
            print(NetworkError.invalidResponse)
            throw NetworkError.invalidResponse
        }
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        return try JSONDecoder().decode([Location].self, from: data)
    }
    
    //Fetch Weather using Lat/Longtitude
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        guard let url = URL(string: "\(Constants.dateURL)?lat=\(lat)&lon=\(lon)&appid=\(Constants.apiKey)") else { throw NetworkError.invalidUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            // Handle error status codes from the server
            throw NetworkError.invalidResponse
        }
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
