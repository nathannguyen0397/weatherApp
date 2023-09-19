//
//  ScrollMainView.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 8/30/23.
//

import SwiftUI

struct ScrollMainView: View {
    @EnvironmentObject var viewModelWeather : ViewModelWeather
    @State private var scrollOffset: CGFloat = 0.0
    let screenHeight : CGFloat = UIScreen.main.bounds.height
    //Header offset y from 100 -> 0
    let minYHeaderOffset: CGFloat = 0
    let maxYHeaderOffset: CGFloat = 100
    
    //Scrolling items move from 186 -> -12
    var body: some View {
        let headerYOffset : CGFloat = scrollOffset/200*100
        if !viewModelWeather.cityWeatherInfo.isEmpty{
            let pageNumber = viewModelWeather.pageNumber
            let weatherInfo = viewModelWeather.cityWeatherInfo[pageNumber]
            ZStack{
                // MARK: Header
                VStack {
                    Text(weatherInfo.city)
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                    //  .aspectRatio(contentMode: .fit)
                    ZStack{
                        if scrollOffset < -25 {
                            Text("\(weatherInfo.tempNow) | \(weatherInfo.condition)")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .offset(y: -30)
                                .opacity(1 - interpolatedOpacityFromScrollOffset(startVal: -30, endVal: -50)) //Opacity (1->0) on scrollOffset (55->20CGF)
                            
                        }
                        Text(weatherInfo.tempNow)
                            .font(.system(size: 90, weight: .thin))
                            .foregroundColor(.white)
                            .opacity(interpolatedOpacityFromScrollOffset(startVal: 30, endVal: -30)) //Opacity (1->0) on scrollOffset (55->20CGF)
                    }
                    Text(weatherInfo.condition)
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0.7176, green: 0.9529, blue: 0.9843))
                        .padding(.bottom, 1)
                        .opacity(interpolatedOpacityFromScrollOffset(startVal: 80, endVal: 30)) //Opacity (1->0) on scrollOffset (55->20CGF)
                    Text("H:\(weatherInfo.temHigh)  L:\(weatherInfo.temLow)")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .opacity(interpolatedOpacityFromScrollOffset(startVal: 150, endVal: 80)) //Opacity (1->0) on scrollOffset (150->80CGF)
                    
                    Spacer()
                }
                .offset(y: headerYOffset > 0 ? headerYOffset : 0)
                
                // MARK: ScrollView
                ScrollView {
                    GeometryReader { geometry -> Color in
                        let y = geometry.frame(in: .global).minY
                        DispatchQueue.main.async {
                            self.scrollOffset = y
                        }
                        return Color.clear
                    }
                    .frame(height: 200)
                    
                    
                    // MARK: ScrollView Content
                    //Horizontal ScrollView: Forecast by Hour
                    VStack(alignment: .leading){
                        Text("\(weatherInfo.condition) condition will continue all day")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                            .frame(alignment: .leading)
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                        Rectangle()
                            .padding(.horizontal , 20)
                            .frame(height: 1)
                            .foregroundColor(.white).opacity(0.25)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(weatherInfo.hourlyInfo, id: \.time) { hourlyCondition in
                                        VStack(spacing: 2){
                                            Text(hourlyCondition.time)
                                                .font(.system(size: 18, weight: .medium))
                                                .foregroundColor(.white)
                                            AsyncImage(url: URL(string: hourlyCondition.iconUrl)){image in
                                                image.image?.resizable()
                                                    .frame(width: 50, height: 50)
                                                    .aspectRatio(contentMode: .fit)
                                            }
//                                            Image(systemName: hourlyCondition.iconSF)
//                                                .resizable()
//                                                .frame(width: 30, height: 30)
//                                                .aspectRatio(contentMode: .fit)
                                            Text(hourlyCondition.temp)
                                                .font(.system(size: 18, weight: .medium))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 20, trailing: 0))
                            }
                        }
                    .background(.blue.opacity(0.15))
                    .cornerRadius(20)
                    .padding()
                    
                    //16-DAY FORECAST
                    DailyView()
                    
                    //WEATHER CONDITIONS
                    ScrowGridView()
                        .padding(.bottom, 10)
                }
                .offset(y: 125)
                .scrollIndicators(.hidden)
            }
            .safeAreaInset(edge: .top, alignment: .center, spacing: 0 ) {
                Spacer()
                    .frame(height: 30)
            }
        }
        else{
            ProgressView("Loading…")
                .scaleEffect(2.0)
        }
    }
    
    func interpolatedOpacityFromScrollOffset(startVal: CGFloat, endVal: CGFloat) -> Double{
        let interpolatedOpacity: Double
        
        if scrollOffset > startVal {
            interpolatedOpacity = 1
        } else if scrollOffset < endVal {
            interpolatedOpacity = 0
        } else {
            interpolatedOpacity = Double(scrollOffset - endVal) / Double(startVal - endVal)
        }
        return interpolatedOpacity
    }
}

struct ScrollMainView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            BackgroundView()
            ScrollMainView()
        }
        .environmentObject(ViewModelWeather())
    }
}

