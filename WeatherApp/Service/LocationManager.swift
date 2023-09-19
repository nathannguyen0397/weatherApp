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
//NSObject is supper classs for CLLocationManagerDelegate - an old Apple Framework (Delegate pattern)
class LocationManager: NSObject, ObservableObject{
    //Access to Long/lat
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion()
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //use best accuracy
//        locationManager.distanceFilter = kCLDistanceFilterNone //  report all movement on the device
        locationManager.requestWhenInUseAuthorization() //request for location permission
//        locationManager.requestLocation() Instead of monitoring the location change, we only need this for location update once
        locationManager.startUpdatingLocation() //Start getting user location, ***need to update Info.plist!***
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.delegate = self //Set delegate to location manager, receive update/message then response accordingly. The delegate property is set to self, meaning that this class (LocationManager) will handle events from the locationManager
    }
}

extension LocationManager: CLLocationManagerDelegate{
    //Called when location is updated
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return} //get the last update(current location)
        locationManager.stopUpdatingLocation()
//        DispatchQueue.main.async {
            self.location = location
            //create region around the location(use for map for futher implementation)
            self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
//        }
    }
}

//Resources
//https://www.youtube.com/watch?v=HfPTp3Qdyog&list=PL9VJ9OpT-IPSM6dFSwQCIl409gNBsqKTe&index=92
