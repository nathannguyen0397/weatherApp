//
//  MainView.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 8/29/23.
//

import SwiftUI
import MapKit

struct MainView: View {
    @State private var showLandView = true
    @State private var isMapShown = false
    @State private var path = NavigationPath()
    var body: some View {
        ZStack{
            NavigationStack(path: $path){
                ZStack{
                    BackgroundView()
                    VStack{
                        VStack(alignment: .leading){
                            ScrollMainView()
                            Spacer().frame(height: 125)
                            TabViewBottom(isMapShown: $isMapShown)
                        }
                    }
                    if isMapShown{
                        LocationMap(isMapShown: $isMapShown)
                    }
                }
            }
            VStack{
                if showLandView{
                    LandView(isShown: $showLandView)
                }
            }
        }
    }
    
    struct LocationMap: View{
        @Binding var isMapShown: Bool
//        @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3394, longitude: -121.895), latitudinalMeters: 25000, longitudinalMeters: 25000)
        @EnvironmentObject private var locationManager: LocationManager
        var body: some View{
            ZStack(alignment: .topLeading){
                Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                    .background(.black.opacity(0.5))
                    .edgesIgnoringSafeArea([.bottom])
                    .accentColor(Color(.systemBlue))
                    .transaction { transaction in //Disable any unexpected animations performing on the view
                        transaction.animation = nil
                    }
                Button {
                    isMapShown = false
                } label: {
                    Text("Done")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.5))
                        .cornerRadius(10)
                }
                .offset(x: 25, y: 25)
            }
            .padding(.top, 50)
            .background(.black.opacity(0.8))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModelWeather())
            .environmentObject(LocationManager())
    }
}
