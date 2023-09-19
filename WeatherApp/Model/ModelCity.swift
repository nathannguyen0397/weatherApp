//
//  ModelCity.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 9/1/23.
//

import Foundation

extension Constant{
    /*This is an insecure endpoint so that it is necessary to edit Info.plist (Not recommended in production environment)*/
    static let geonamesBaseUrl = "http://api.geonames.org/searchJSON?"
    static let geonamesUsername = "natenate111111"
}

struct GeonamesResponse: Codable, Hashable{
    //geonames is an array of cities/locations
    let geonames: [CityGeonames]
}

struct CityGeonames: Codable, Identifiable, Hashable{
    let id: Int
    let name: String //City name
    let stateCode: String //State Code
    let countryName: String
    let lng: String
    let lat: String
    
    enum CodingKeys: String, CodingKey{
        case id = "geonameId"
        case name
        case stateCode = "adminCode1"
        case countryName
        case lng
        case lat
    }
}



