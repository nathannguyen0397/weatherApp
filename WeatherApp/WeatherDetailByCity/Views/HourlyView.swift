//
//  HourlyView.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/15/23.
//

import SwiftUI

struct HourlyView: View {
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        VStack{
            Text("Sunny conditions will continue all day")
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.bottom, 10)
                .overlay(
                    Rectangle()
                        .padding(.leading, 20)
                        .frame(height: 1)
                        .foregroundColor(.white).opacity(0.25),
                        alignment: .bottom
                )

            ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(HourlyData.mockData) { hour in
                            VStack(spacing: 10) {
                                Text(hour.time)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                Image(systemName: hour.image)
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.yellow)
                                
                                Text(hour.temperature)
                                    .font(.title3).bold()
                                    .foregroundColor(.white)
                                
                            }
                            //                    .background(.green)
                        }
                        .padding(10)
                    }
                    .padding(.leading, 10)
                }
        }
        .padding(.top, 10)
        .frame(width:  screenWidth - 30, height: 160, alignment: .leading)
        .background(Color(hex: "#2773b9")).opacity(0.8)
        .cornerRadius(20)
        
    }
}


struct HourlyView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView()
    }
}
