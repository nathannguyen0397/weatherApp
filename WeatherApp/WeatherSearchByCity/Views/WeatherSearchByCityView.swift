//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 6/28/23.
//

import SwiftUI

struct WeatherSearchByCityView: View {
    @State var searchText = ""
    @ObservedObject var viewModel = WeatherViewModel(service: WeatherService())
    var body: some View {
        NavigationStack {
            ZStack {
                // Background image ignoring safe area
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                Color(hex: "#33bbfa").opacity(0.15)
                    .ignoresSafeArea()
                //City Weather List
                VStack {
                    Spacer()
                        .frame(height: 100)
                    VStack {
                        ForEach(viewModel.weatherList) { weather in
                            WeatherCell(weather: weather)
                        }
                        .padding()
                        .foregroundColor(.white).opacity(0.9)

                        .background(Color(.black).opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 0.5)
                        )
                        
                    }
                    Spacer()
                    
                }
                .padding()
                .navigationTitle(Text("Weather"))
                
                //Navigation Button
                Button(action: {
                    print("button clicked")
//                    #error("Working on this")
                    LocationManager.shared.getLocation { (lon, lat) in
                        print("Longitude: \(lon), Latitude: \(lat)")
                    }
                }) {
                    Image(systemName: "location.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white).opacity(0.9)
                }
                .position(x:UIScreen.main.bounds.width - 50, y:UIScreen.main.bounds.height - 150)
            }
        }
        .searchable(text: $searchText, prompt: "Search for a city/state in USA")
        .onSubmit(of: .search) {
            viewModel.fetchWeather(by: searchText)
        }
        
        
    }
}

struct WeatherSearchByCityView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSearchByCityView()
    }
}
