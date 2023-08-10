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
        //create region around the cocation
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}










//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
//    var locationManager: CLLocationManager?
//    @Published var location: CLLocation?
//
//
//    func checkIfLocationServicesIsEnabled(){
//        if CLLocationManager.locationServicesEnabled(){
//            locationManager = CLLocationManager()
//            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
//            checkLocationAuthorization()
//            locationManager!.delegate = self
//        } else {
//            print("Show an alert letting them know this is off and go turn it on")
//        }
//    }
//
//    func checkLocationAuthorization() {
//        guard let locationManager = locationManager else {return}
//
//        switch locationManager.authorizationStatus{
//
//        case .notDetermined: //ask for location permission
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            print("Your location is restricted")
//        case .denied:
//            print("Your location request is denied. Change it in setting")
//        case .authorizedAlways, .authorizedWhenInUse:
//            break
//        @unknown default:
//            break
//        }
//    }
//
////    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
////        checkLocationAuthorization()
////    }
//
//}
//
//extension LocationManager{
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {return}
//        self.location = location
//    }
//}
