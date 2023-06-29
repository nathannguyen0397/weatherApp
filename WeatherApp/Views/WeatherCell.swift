//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 6/28/23.
//

import SwiftUI

/// This view is responsible for showing the weather data for a city

struct WeatherCell: View {
    let weather: WeatherInfo
    
    var body: some View {
        VStack(spacing: 35) {
            cityWeather
            averageWeather
        }
        .background(Color.clear)
    }
    
    var cityWeather: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(weather.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(weather.time)
                    .font(.body)
            }
            Spacer()
            Text(weather.currentTemp)
                .font(.title)
                .fontWeight(.bold)
        }
        .background(Color.clear)
    }
    
    var averageWeather: some View {
        HStack {
            Text(weather.description)
                .font(.body)
            AsyncImage(url: URL(string: weather.iconURLString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            } placeholder: {
                Image(systemName:"cloud.sun")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }

            Spacer()
            Text("H: \(weather.tempHigh) L: \(weather.tempLow)")
                .font(.body)
                .fontWeight(.bold)

        }
        .background(Color.clear)
    }
}

struct WeatherCell_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCell(weather: WeatherInfo.mock)
    }
}
