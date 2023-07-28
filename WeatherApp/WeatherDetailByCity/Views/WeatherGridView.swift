//
//  WeatherGridView.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/15/23.
//

import SwiftUI

struct WeatherGridView: View {
    var body: some View {
        ZStack {
            // Background image ignoring safe area
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            // Yellow opacity color layer
            Color(hex: "#33bbfa")
                .opacity(0.15)
                .ignoresSafeArea()
        }
    }
}





struct WeatherGridView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherGridView()
    }
}
