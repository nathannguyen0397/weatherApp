//
//  ViewModelWeather.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 8/31/23.
//

import Foundation
import Combine

struct ConstantUserDefaultKeys{
    static let keyCitySavedList = "CitySavedList"
    static let cityWeatherList = "CitySavedList"
}

class ViewModelWeather: ObservableObject{
    @Published var citySuggestionList = [CityGeonames]()
    @Published var cityWeatherInfo = [WeatherApiInfo]()
    //City's Weather info that is displayed on main view
    @Published var pageNumber = 0
    
    var cancellableGetCities : Cancellable?
    var cancellablesGetWeather = Set<AnyCancellable>()
    var service = RestAPIService()
    
    init(){
        //Load default weather
        let cityUserDefault = [
            CityGeonames(id: 1, name: "San Jose", stateCode: "CA", countryName: "US", lng: "-121.895", lat: "37.3394"),
            CityGeonames(id: 2, name: "Oakland", stateCode: "CA", countryName: "US", lng: "-122.2712", lat: "37.8044"),
            CityGeonames(id: 3, name: "San Francisco", stateCode: "CA", countryName: "US", lng: "-122.4194", lat: "37.7749"),
            CityGeonames(id: 4, name: "Santa Cruz", stateCode: "CA", countryName: "US", lng: "-122.0308", lat: "36.9741"),
            // Note: San Jose is repeated in the initial data. If you meant another city, please specify.
        ]

        for city in cityUserDefault{
            updateWeatherListWithSelectedCity(city: city){_ in}
        }
    }
    
    // MARK: Fetch city from Geonames API
    func fetchCities(_ searchText: String){
        guard var urlComponent = URLComponents(string: Constant.geonamesBaseUrl) else {
            print("Invalid URL")
            return
        }
        
        urlComponent.queryItems = [
        URLQueryItem(name: "q", value: searchText),
        URLQueryItem(name: "maxRows", value: "30"),
        URLQueryItem(name: "username", value: Constant.geonamesUsername),
        ]
        
        let url = urlComponent.url!
        
        cancellableGetCities = service.getDataJSONPublisher(url: url, type: GeonamesResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .finished:
                    print("Send request Successfully! - fetchCities")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] geonamesResponse in
                DispatchQueue.main.async {
                    self?.citySuggestionList = geonamesResponse.geonames
//                    print(geonamesResponse)
                }
            })
    }
    
    // MARK: Fetch City's Forecast Weather
    func fetchCityForecastWeather(latitude: Double, longitude: Double, completionHandler: @escaping(WeatherApiInfo?, Error?) -> Void) {
        var urlComponent = URLComponents(string: Constant.weatherApiBaseUrl)!
        
        urlComponent.queryItems = [
            URLQueryItem(name: "key", value: Constant.weatherApiKey),
            URLQueryItem(name: "q", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "days", value: "3")

        ]
        
        let url = urlComponent.url!
        
        service.getDataJSONPublisher(url: url, type: WeatherApiResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .finished:
                    print("Send request Successfully! - CityForecastWeather")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completionHandler(nil, error)
                }
            }, receiveValue: {weatherResponse in
                completionHandler(WeatherApiInfo(model: weatherResponse), nil)
            })
            .store(in: &cancellablesGetWeather)
    }
    
    
    // MARK: Update Weather List by Selected City
    /// Updates the weather list with the selected city's weather.
    /// - Parameters:
    ///   - city: The selected city for which the weather needs to be fetched.
    ///   - completionResponse: A completion handler providing the update result.
    ///     - Returns:
    ///       - `-1`: If there was an error fetching the data from the API.
    ///       - `0`: If the weather for the city is already present in the list.
    ///       - `1`: If the weather for the city was successfully added to the list.
    func updateWeatherListWithSelectedCity(city: CityGeonames, userLocation: Bool = false, completionResponse: @escaping (Int) -> Void){
        fetchCityForecastWeather(latitude: Double(city.lat)!, longitude: Double(city.lng)!){[weak self] cityWeather, error in
            if let error = error{
                //TODO: Handle if there is error
                print(error.localizedDescription)
                completionResponse(-1)
            }
            else if let cityWeather = cityWeather{
                let indexOfWeatherInfo = self!.indexOfWeatherInfo(cityWeather)
                if  indexOfWeatherInfo > -1{
                    //TODO: Handle weather is already existed in the list
                    if userLocation{
                        //Make city weather the first item in the list
                        DispatchQueue.main.async {
                            self!.cityWeatherInfo.remove(at: indexOfWeatherInfo)
                            self!.cityWeatherInfo.insert(cityWeather, at: 0)
                        }
                    }
                    completionResponse(0)
                } else {
                    DispatchQueue.main.async {
                        if userLocation{
                            self!.cityWeatherInfo.insert(cityWeather, at: 0)
                        }
                        else{
                            self!.cityWeatherInfo.append(cityWeather)
                        }
                    }
                    completionResponse(1)
                }
//                print(cityWeather.hourlyInfo)
            }
        }
    }
        
    func indexOfWeatherInfo(_ cityWeather: WeatherApiInfo) -> Int {
        for (index, weather) in cityWeatherInfo.enumerated() {
            if weather.lat == cityWeather.lat && weather.lon == cityWeather.lon {
                return index
            }
        }
        return -1
    }
}




//func saveCityUserDefaultFetchWeather(city: CityGeonames) -> Bool{
//    /*The UserDefaults system only supports property-list types: Data, String, Number, Date, Array, and Dictionary.
//     To work with UserDefaults, value must be converted using JSON format and Data type*/
//    let defaults = UserDefaults.standard
//
//    // TODO: Remove for Actual Usage
//    //To remove object associate with a specific key
//    defaults.removeObject(forKey: ConstantUserDefaultKeys.keyCitySavedList)
//
//    //Retrive the list of saved City data
//    var citySavedListDefault = [CityGeonames]()
//    if let dataCitySavedListDefault = defaults.object(forKey: ConstantUserDefaultKeys.keyCitySavedList) as? Data{
//        citySavedListDefault = try! JSONDecoder().decode([CityGeonames].self, from: dataCitySavedListDefault) //Decode data
//    }
//    // TODO: Concurrency Problem! to resoved, Dont save city list but save weather list instead
//    //Sync/Update with City Weather List
//    DispatchQueue.main.async {
//        self.cityWeatherList = [WeatherApiResponse]() //reset the list
//    }
//    for city in citySavedListDefault {
//        fetchCityForecastWeather(latitude: Double(city.lat)!, longitude: Double(city.lng)!)
//    }
//
////        print("Retrieved List: \(citySavedListDefault)")
//
//    //Save city fail, the list already have the same city
//    if citySavedListDefault.contains(city){
//        return false
//    }
//
//    //Save city in UserDefaults successfully
//    citySavedListDefault.append(city)
////        print("Saved List: \(citySavedListDefault)")
//    let dataCitySavedListDefault = try! JSONEncoder().encode(citySavedListDefault) //Encode List of Cities
//    defaults.setValue(dataCitySavedListDefault, forKey: ConstantUserDefaultKeys.keyCitySavedList)
//
//    //sync data with ViewModelWeather
//    DispatchQueue.main.async {
//        self.citySavedList = citySavedListDefault
//    }
//
//
//    return true
//}
