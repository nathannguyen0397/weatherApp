//
//  DailyView.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/15/23.
//

import SwiftUI

struct DailyView: View {
    @EnvironmentObject var viewModelWeather : ViewModelWeather
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        if !viewModelWeather.cityWeatherInfo.isEmpty{
            let pageNumber = viewModelWeather.pageNumber
            let weatherInfo = viewModelWeather.cityWeatherInfo[pageNumber]
            let dailyData = DailyMockData(weatherInfo: weatherInfo)
            VStack {
                // MARK: Header
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 20, height: 16)
                        Text("16-DAY FORECAST")
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white).opacity(0.25)
                }
                .foregroundColor(.white)
                
                // MARK: Daily info
                ForEach(dailyData.days) { data in
                    VStack{
                        HStack{
                            Text(data.day)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 60, alignment: .leading)
                                .overlay {
                                    AsyncImage(url: URL(string: data.iconUrl )){image in
                                        image.image?.resizable()
                                            .frame(width: 45, height: 35)
                                            .aspectRatio(contentMode: .fill)
                                            .offset(x: 35)
                                    }
                                }
                            
                            Spacer()
                            HStack{
                                Text(data.lowString)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
//                                    .frame(width: 40, alignment: .trailing)
                                TemperatureBar(tempMax: dailyData.tempMax, tempMin: dailyData.tempMin, tempLow: data.tempLow, tempHigh: data.tempHigh, tempCurr: data.day == "Today" ? dailyData.tempCurr : nil)
                                Text(data.highString)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: 40, alignment: .leading)
                            }
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white).opacity(0.25)
                    }
                }
            }
            .padding()
            .background(.blue.opacity(0.2))
            .cornerRadius(20)
            .padding()
        }
    }
}

struct TemperatureBar: View{
    let tempMax: Double
    let tempMin: Double
    let tempLow: Double
    let tempHigh: Double
    let tempCurr: Double?
    let widthTempBarMax: CGFloat = 128.0 //100%
    var body: some View{
        let widthDaily = (tempHigh - tempLow) / (tempMax - tempMin) * widthTempBarMax
        let widthLost = widthTempBarMax - widthDaily
        let widthSpacerLeft = (tempLow - tempMin) / (tempMax - tempMin) * widthTempBarMax
        let widthSpacerRight = (tempMax - tempHigh) / (tempMax - tempMin) * widthTempBarMax
        VStack{
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 10)
                    .overlay(content: {
                        Color.blue
                    })
                    .opacity(0.1)

                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green, Color.yellow, Color.orange]), startPoint: .leading, endPoint: .trailing))
                    .mask(
                        // Mask using a Rounded Rectangle in the middle
                        HStack(){
                            Spacer()
                                .frame(width: widthSpacerLeft)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: widthDaily)
                            Spacer()
                                .frame(width: widthSpacerRight)
                        }
                        .frame(width: widthTempBarMax)
                    )


                if let tempCurr = tempCurr{
                    let tempCurrOffset = (tempCurr - tempMin) / (tempMax - tempMin) * widthTempBarMax
                    Circle()
                        .foregroundColor(.white)
                        .overlay {
                            Circle()
                                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                        }
                        .scaleEffect(1.75)
                        .offset(x: tempCurrOffset)
                }
            }
            
        }
        .frame(width: widthTempBarMax, height: 5)

    }
}

struct DailyMockData{
    let weatherInfo: WeatherApiInfo
    let tempCurr: Double
    var tempMax = -150.0
    var tempMin = 150.0
    let weatherIconProvider = WeatherIconProvider.shared
    var days: [Day] = []
    
    init(weatherInfo: WeatherApiInfo){
        self.weatherInfo = weatherInfo
        self.tempCurr = weatherInfo.model.current.temp_f
        constructData()
        print((tempMax, tempMin))
    }
    
    mutating func constructData(){
        //Today
        let tempLow = (weatherInfo.model.forecast.forecastday.first?.day.mintemp_f)!
        let tempHigh = (weatherInfo.model.forecast.forecastday.first?.day.maxtemp_f)!
        days.append(Day(day: "Today", iconUrl: weatherInfo.iconUrl, tempLow: tempLow, tempHigh: tempHigh, lowString: weatherInfo.temLow, highString: weatherInfo.temHigh))
        self.tempMin = tempLow
        self.tempMax = tempHigh

        //Next 15 days
        let weatherIconProvider = WeatherIconProvider.shared
        let conditions = weatherIconProvider.conditions
        
        for Index in 1...15{
            let nextdayEpoch = weatherInfo.model.location.localtime_epoch + 86400*Index // 86400 seconds = 24 hours
            let nextDay = timeEpochtoWeekday(timeEpoch: nextdayEpoch)
            
            let condition = conditions[Int.random(in: 0..<conditions.count)]
            let iconNum = condition.icon
            let iconUrl = String("https://cdn.weatherapi.com/weather/64x64/day/\(iconNum).png")
            
            let dailyHigh = Double.random(in: self.tempMax - 5...self.tempMax + 3)
            self.tempMax = Double.maximum(self.tempMax, dailyHigh) //Compute max temp of 16 days
            let dailyLow = Double.random(in: self.tempMin - 3...self.tempMin + 5)
            self.tempMin = Double.minimum(self.tempMin, dailyLow) //Compute min temp of 16 days
            let highString = String(Int(ceil(dailyHigh))) + "°"
            let lowString = String(Int(ceil(dailyLow))) + "°"
            self.days.append(Day(day: nextDay, iconUrl: iconUrl, tempLow: dailyLow, tempHigh: dailyHigh, lowString: lowString, highString: highString))
        }
        print(tempMax, tempMin)
    }
    
    func timeEpochtoWeekday(timeEpoch: Int) -> String{
        let date = Date(timeIntervalSince1970: Double(timeEpoch))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        var day = dateFormatter.string(from: date)
        day = String(day.prefix(3))
        return day
    }
    
    struct Day: Identifiable {
        let id = UUID()
        let day: String
        let iconUrl: String
        let tempLow: Double
        let tempHigh: Double
        let lowString: String
        let highString: String
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            BackgroundView()
            ScrollView{
                DailyView()
            }
        }
        .environmentObject(ViewModelWeather())
    }
}
