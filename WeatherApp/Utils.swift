//
//  Utils.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 6/28/23.
//
import Foundation
import CoreLocation
import SwiftUI
import Combine
//Helper for Hexa color || Color(hex: "#ffee00").opacity(0.75)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(1)
        )
    }
}


//// This class is responsible for managing the user's location by requesting permission, updating the location, and should handle errors.
//final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    static let shared = LocationManager()
//    
//    let manager = CLLocationManager()
//    
//    var completion: (((lon: Double, lat: Double)) -> Void)?
//    
//    func getLocation(completion: (((lon: Double, lat: Double)) -> Void)?) {
//        self.completion = completion
//        manager.requestWhenInUseAuthorization()
//        manager.delegate = self
//        manager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else {
//            return
//        }
//        manager.stopUpdatingLocation()
//        completion?((lon: location.coordinate.longitude,
//                     lat: location.coordinate.latitude))
//    }
//    
//}
