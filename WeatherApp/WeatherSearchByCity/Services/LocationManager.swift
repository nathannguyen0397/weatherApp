//
//  LocationService.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 8/9/23.
//

import Foundation
import CoreLocation
import MapKit
//Singleton Location Manager
//Requirement: add Privacy - Location When In Use Usage Description in target info
//NSObject is for delegate pattern 
@MainActor
class LocationManager: NSObject, ObservableObject{
    //Access to Long/lat
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion()
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //use best accuracy
        locationManager.distanceFilter = kCLDistanceFilterNone //  report all movement on the device
        locationManager.requestWhenInUseAuthorization() //request for location permission
        locationManager.startUpdatingLocation() //Start getting user location, ***need to update Info.plist!***
        locationManager.delegate = self //Set delegate to location manager, receive update/message then response accordingly
    }
}

extension LocationManager: CLLocationManagerDelegate{
    //Called when location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return} //get the last update(current location)
        self.location = location
        //create region around the location(use for map for futher implementation)
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}


