//
//  TemperatureBarView.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/14/23.
//

import SwiftUI

struct TemperatureBarView: View {
    var body: some View {
        VStack{
            ZStack(alignment: .leading) {
                LinearGradient(gradient: Gradient(colors: [.blue, .green, .yellow,.red]), startPoint: .leading, endPoint: .trailing)
                    .cornerRadius(5)
            }
        }
    }
}

struct TemperatureBarView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureBarView()
    }
}

