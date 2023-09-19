//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 6/28/23.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject var viewModel = ViewModelWeather()
    @StateObject var locationManger = LocationManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
                .environmentObject(locationManger)
        }
    }
}

//@main
//struct WeatherApp: App {
//    @StateObject var viewModel = ViewModelWeather()
//    
//    @Environment(\.scenePhase) private var scenePhase
//
//    var body: some Scene {
//        WindowGroup {
//            MainView()
//                .environmentObject(viewModel)
//                .onChange(of: scenePhase) { newPhase in
//                    if newPhase == .inactive {
//                        saveData()
//                    }
//                }
//        }
//    }
//    
//    func saveData() {
//        // Save your data to UserDefaults
//    }
//}
