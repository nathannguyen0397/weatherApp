//
//  DailyView.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/15/23.
//

import SwiftUI

struct DailyView: View {
    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        
        VStack {
            HStack{
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 20, height: 16)
                Text("10-DAY FORECAST")
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(Color(hex: "#b7f3fb"))
            .padding(.bottom, 10)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white).opacity(0.25),
                alignment: .bottom
            )
            ForEach(DayData.mockData) { dayData in
                HStack {
                    Text(dayData.day)
                        .font(.title3).bold()
                        .foregroundColor(.white)
                        .frame(width: 75, alignment: .bottomLeading)
                        .padding(.vertical, 12)
                    Image(systemName: dayData.image)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.yellow)
                    Spacer()
                    Text(dayData.highTemp + "°")
                        .font(.title3).bold()
                        .foregroundColor(Color(hex: "#b7f3fb")).opacity(0.8)
                    //Fake progress or temperature range bar
                    ZStack{
                        Rectangle()
                            .cornerRadius(20)
                            .background(.clear).opacity(0.3)
                        TemperatureBarView()
                            .padding(.leading, CGFloat.random(in: 1...50))
                            .padding(.trailing, CGFloat.random(in: 1...50))
                        Rectangle()
                            .frame(width: dayData.day == "Today" ? 5 : 0)
                            .foregroundColor(dayData.day == "Today" ? .white : .clear)
                            .cornerRadius(40)
                    }
                    .frame(width: 110, height: 5)
                    .padding(5)
                    .cornerRadius(20)
                    Text(dayData.lowTemp + "°")
                        .font(.title3).bold()
                        .foregroundColor(.white)
                }
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white).opacity(0.25),
                    alignment: .bottom
                )
            }
            
        }
        .padding(20)
        .frame(width:  screenWidth - 30, alignment: .leading)
        .background(Color(hex: "#2773b9")).opacity(0.8)
        .cornerRadius(20)
    }
}
struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()
    }
}
