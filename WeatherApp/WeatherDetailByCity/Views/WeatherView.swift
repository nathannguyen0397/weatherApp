//
//  ContentView.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/14/23.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        NavigationView{
            ZStack {
                // Background image ignoring safe area
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                Color(hex: "#33bbfa").opacity(0.15)
                    .ignoresSafeArea()
                VStack{
                    VStack{
                        HeaderView()
                        ScrollView(.vertical, showsIndicators: false) {
                            HourlyView()
                            DailyView()
                            ScrowGridView()

                        }
                    }
                    PaginationView()
                }
                .brightness(0.05)
            }
        }
    }
    
}





struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
