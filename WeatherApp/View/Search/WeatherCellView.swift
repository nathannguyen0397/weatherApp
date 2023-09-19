//
//  CellView.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 8/30/23.
//

import SwiftUI

struct WeatherCellView: View {
    @State private var rotation: Angle = .degrees(-4)
    let weatherInfo: WeatherApiInfo
    var body: some View {
        
        ZStack{
            Image("CellViewDay")
                .resizable()
                .saturation(1.5)
                .brightness(0.1)
                .scaleEffect(Double.random(in: 1.0...3.0))
                .rotationEffect(rotation)
                .overlay(content: {
                    Color(.yellow).opacity(0.1)
                })
                .overlay {
                    VStack(spacing: 10) {
                        cityWeather
                        averageWeather
                    }
                    .foregroundColor(.white)
                    .padding()
                }
        }
        .frame(height: 120)
        .cornerRadius(20)
        .padding(.horizontal)
        .onAppear() {
            withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: true)) {
                rotation = .degrees(4)
            }
        }
    }
    
    var cityWeather: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(weatherInfo.city)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(weatherInfo.timeLocal)
                    .font(.body)
            }
            Spacer()
            Text(weatherInfo.tempNow)
                .font(.largeTitle)
        }
    }
    
    var averageWeather: some View {
        HStack {
            Text("\(weatherInfo.condition)")
                .font(.body)
            AsyncImage(url: URL(string: weatherInfo.iconUrl)){image in
                image.image?.resizable()
                    .frame(width: 50, height: 50)
            }
            Spacer()
            Text("H: \(weatherInfo.temHigh) L: \(weatherInfo.temLow)")
                .font(.body)
        }
    }
}

//struct CellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack{
//            Color.black
//            WeatherCellView(cityName: "Dummy", tempC: 99)
//        }
//
//    }
//}
