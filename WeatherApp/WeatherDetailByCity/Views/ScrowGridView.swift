//
//  ScrowGridView.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/15/23.
//

import SwiftUI

struct ScrowGridView: View {
    var body: some View {
        let columns: [GridItem] = [
            GridItem(.adaptive(minimum: 130, maximum: 250),alignment: .center)
        ]
        VStack{
//            HeaderGridView()
            //Weather Grids
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                   ForEach(WeatherConditionIndex.mockData) { conditionIndex in
                       VStack {
                           //Image and condition
                           HStack{
                               Image(systemName: conditionIndex.image)
                                   .resizable()
                                   .frame(width: 14, height: 14)
                               Text(conditionIndex.condition)
                                   .font(.system(size: 14, weight: .medium))
                           }
                           .foregroundColor(Color(hex: "#b7f3fb"))
                           .frame(width:  UIScreen.main.bounds.width / 2 - 20, alignment: .topLeading)
                           
                           //Index and Description
                           if conditionIndex.condition == "WIND" {
                               WindIndicatorView(index: conditionIndex.index)
                           }
                           if conditionIndex.condition == "PRESSURE" {
                               PressureIndicatorView(index: conditionIndex.index)
                           }
                           if !conditionIndex.description.isEmpty{
                               Text(conditionIndex.index)
                                   .font(.system(size: 26, weight: .medium))
                                   .frame(width:  UIScreen.main.bounds.width / 2 - 20, height: 70, alignment: .topLeading)
                               Text(conditionIndex.description)
                                   .font(.system(size: 15, weight: .medium))
                                   .frame(width:  UIScreen.main.bounds.width / 2 - 20, alignment: .bottomLeading)
                           }
                       }
                       .foregroundColor(.white)
                       .padding(15)
                       .frame(width:  UIScreen.main.bounds.width / 2 - 20, height: conditionIndex.index.isEmpty ? 40 : 180 ,alignment: .leading)
                       .background(Color(hex: "#2773b9")).opacity(0.9)
                       .cornerRadius(15)
                   }
               }
           }
            .padding(.horizontal, 15)
        }
    }
}

struct WindIndicatorView: View {
    let index: String
    init(index: String) {
            self.index = index
        }
    var body: some View {
        ZStack{

            //Generate lines
            ForEach(0..<240) { index in
                    Rectangle()
                    .frame(width: 0.5, height: 10)
                    .foregroundColor(.white).opacity(0.5)
                    .offset(y: -55)
                    .rotationEffect(.degrees(Double(index) * 1.5)) //Rotate the line

                }
            //Critical lines
            ForEach(0..<4) { index in
                    Rectangle()
                    .frame(width: 0.75, height: 10)
                    .foregroundColor(.white).opacity(0.8)
                    .offset(y: -55)
                    .rotationEffect(.degrees(Double(index) * 90)) //Rotate the line

                }
            
            ForEach(0..<12) { index in
                    Rectangle()
                    .frame(width: 0.75, height: 10)
                    .foregroundColor(.white).opacity(0.5)
                    .offset(y: -55)
                    .rotationEffect(.degrees(Double(index) * 30)) //Rotate the line
                }
            
            //Indicator
            ZStack{
                Image(systemName: "triangle.fill")
                    .resizable()
                    .frame(width: 5, height: 5)
                    .padding(.bottom, 110)
                Text("N")
                    .font(.system(size: 12, weight: .medium))
                    .padding(.bottom, 85)
                Text("S")
                    .font(.system(size: 12, weight: .medium))
                    .padding(.top, 85)
                Text("E")
                    .font(.system(size: 12, weight: .medium))
                    .padding(.leading, 85)
                Text("W")
                    .font(.system(size: 12, weight: .medium))
                    .padding(.trailing, 85)
            }
            
            //Inner Arrow
            ZStack{
                Image(systemName: "arrow.up")
                    .resizable()
                    .frame(width: 20, height: 30)
                    .foregroundColor(.white)
                    .offset(y: -40)
                    .rotationEffect(.degrees((Double(index) ?? 0) / 60 * 360))
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                    .offset(y: -55)
                    .rotationEffect(.degrees((Double(index) ?? 0) / 60 * 360 + 180))
                
                Rectangle()
                    .frame(width: 2, height: 25)
                    .foregroundColor(.white)
                    .offset(y: -37)
                    .rotationEffect(.degrees((Double(index) ?? 0) / 60 * 360 + 180))
            }
            
            //Wind speed
            ZStack{
                Rectangle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white).opacity(0.05)
                    .cornerRadius(40)
                    .shadow(color: .black, radius: 5, x: 0, y: 0)
                Text(index)
                    .font(.system(size: 25, weight: .medium))
                    .padding(.bottom, 20)
                Text("mph")
                    .font(.system(size: 15, weight: .medium))
                    .padding(.top, 10)
                
            }
            
        }
        .frame(width:  120, height: 120)
        .padding(.trailing, 28)
    }
}

struct PressureIndicatorView: View {
    let index: String
    init(index: String) {
            self.index = index
        }
    var body: some View {
        ZStack{
            //Critical lines
            ForEach(41..<80) { index in
                    Rectangle()
                    .frame(width: 0.75, height: 10)
                    .foregroundColor(.white).opacity(0.8)
                    .offset(y: -60)
                    .rotationEffect(.degrees(Double(index) * 6)) //Rotate the line
                }
            
            Text("Low")
                .font(.system(size: 15, weight: .medium))
                .padding(.top, 75)
                .padding(.trailing, 80)

            Text("High")
                .font(.system(size: 15, weight: .medium))
                .padding(.top, 75)
                .padding(.leading, 75)
            
            
            //Inner Arrow
            Image(systemName: "arrow.up")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .offset(y: -40)
                .rotationEffect(.degrees((Double(index) ?? 0) / 60 * 360 - 180))
            
            Rectangle()
                .frame(width: 3, height: 12)
                .foregroundColor(.white)
                .offset(y: -60)
                .rotationEffect(.degrees((Double(index) ?? 0) / 60 * 360 - 180))
                        
            Circle()
                .strokeBorder(
                    AngularGradient(
                        gradient:
                            Gradient(colors: [.clear, Color.white.opacity(0.5)]),
                        center: .center,
                            startAngle: .degrees(180),
                            endAngle: .degrees(360)),
                    lineWidth: 15
                )
                .frame(width: 130, height: 130)
                .rotationEffect(.degrees((Double(index) ?? 0) / 60 * 360))
            
            //Pressure
            ZStack{
                Text(index)
                    .font(.system(size: 25, weight: .medium))
                    .padding(.bottom, 20)
                Text("inHg")
                    .font(.system(size: 15, weight: .medium))
                    .padding(.top, 20)
            }
            
        }
        .frame(width:  120, height: 120)
        .padding(.trailing, 28)
    }
}



struct ScrowGridView_Previews: PreviewProvider {
    static var previews: some View {
        ScrowGridView()
    }
}
