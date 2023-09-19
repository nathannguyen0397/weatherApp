//
//  SearchView.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 8/30/23.
//

import SwiftUI

//Preview() will got crashed if we dont pass environmentObject to it

struct SearchView: View {
    @State private var searchText = ""
    @EnvironmentObject var viewModelWeather : ViewModelWeather
    @EnvironmentObject var locationManager : LocationManager
    @Environment(\.presentationMode) var presentationMode
    
    var isSearching: Bool{
        !searchText.isEmpty
    }
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                ScrollView{
                    // MARK: ScrollView Content
                    if isSearching{
                        citySuggestionsView(seachText: $searchText, cities: viewModelWeather.citySuggestionList)
                            .padding()
                    }
                    else{
                        ForEach(viewModelWeather.cityWeatherInfo.indices, id: \.self) { index in
                            //Fetch Forecase Weather
                            Button {
//                                print("City: ", viewModelWeather.cityWeatherInfo[index].city, index)
                                //Display Main View with selected City by changing pageNumber
                                viewModelWeather.pageNumber = index
                                //Back to Main View
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                WeatherCellView(weatherInfo: viewModelWeather.cityWeatherInfo[index])
                            }
                            
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal)
                
                Button(action: {
                    let lat = locationManager.location?.coordinate.latitude ?? 37.323 //Seoul by default
                    let lon = locationManager.location?.coordinate.longitude ?? -122.032
                    //                    DispatchQueue.global().async {
                    //                        locationViewModel.checkIfLocationServicesIsEnabled()
                    //                    }
                    print("Location: ", lat, lon)
                    let city = CityGeonames(id: 0, name: "", stateCode: "", countryName: "", lng:  String(lon), lat: String(lat))
                    viewModelWeather.updateWeatherListWithSelectedCity(city: city, userLocation: true) { responseCode in
                        // TODO: Handle the response
                    }
                }) {
                    Image(systemName: "location.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                }
                .position(x:UIScreen.main.bounds.width - 50, y:UIScreen.main.bounds.height - 250)
            }
            .toolbarBackground(.black, for:.navigationBar,.tabBar)
            
        }
        .toolbar{
            ToolbarItem(placement: .principal) {
                ZStack{
                    HStack(alignment: .center){
                        Text("Weather")
                            .font(.system(size: 22, weight: .bold))
                    }
                    HStack() {
                        Spacer()
                        Menu {
                            Button {} label: {
                                Text("Edit List")
                                Image(systemName: "pencil")
                            }
                            Button(action: {}) {
                                HStack {
                                    Text("Notifications")
                                    Image(systemName: "bell")
                                }
                            }
                            
                            Button(action: {}) {
                                HStack {
                                    Text("Celsius")
                                    Image(systemName: "thermometer")
                                }
                            }
                            
                            Button(action: {}) {
                                HStack {
                                    Text("Fahrenheit")
                                    Image(systemName: "thermometer")
                                }
                            }
                            
                            Button(action: {}) {
                                HStack {
                                    Text("Report an Issue")
                                    Image(systemName: "exclamationmark.triangle")
                                }
                            }
                            
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .bold()
                                .offset(x: 20)
                        }
                    }
                }
            }
        }
        .foregroundColor(.white)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a city")
        .onChange(of: searchText) { searchKey in
            //            print("\(searchKey)")
            viewModelWeather.fetchCities(searchKey)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ViewModelWeather())
            .environmentObject(LocationManager())
    }
}


class ServiceWeather{
    let apiKey = "TFfs9zT90KeDNxbvV23lww==2PT8WkGU5BW8I0yE"
    
    
}

//A List of city suggestions that has search key highlighted
struct citySuggestionsView: View {
    @EnvironmentObject var viewModelWeather: ViewModelWeather
    @Binding var seachText: String
    let cities : [CityGeonames]
    var citiesList : [(String, CityGeonames)] {
        //Map and sort city array to city turple with (fullname, city object)
        cities
            .map{city in
                return ("\(city.name), \(city.stateCode) \(city.countryName)", city)
            }
            .sorted { (city1, city2) -> Bool in
                if city1.0.contains(seachText), !city2.0.contains(seachText) {
                    return true
                } else if !city1.0.contains(seachText), city2.0.contains(seachText) {
                    return false
                } else {
                    return city1.0 < city2.0
                }
            }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            ForEach(citiesList, id: \.1.id) { (cityStateCountryString, city) in
                Button {
                    viewModelWeather.updateWeatherListWithSelectedCity(city: city){ updateStatus in
                        switch updateStatus{
                        case -1:
                            print("Error")
                        case 0:
                            print("Selected City is already in the list")
                        case 1:
                            print("Selected City has been added")
                        default:
                            break
                        }
                    }
                    seachText = ""
                } label: {
                    HStack(spacing: 0) {
                        let cityStateCountrydiacriticInsensitive = cityStateCountryString
                        //There's a case when "San Jose" vs "San José"
                        if let range = cityStateCountrydiacriticInsensitive.range(of: seachText, options: .diacriticInsensitive) {
                            let prefix = String(cityStateCountryString[cityStateCountryString.startIndex..<range.lowerBound])
                            let match = String(cityStateCountryString[range])
                            let suffix = String(cityStateCountryString[range.upperBound..<cityStateCountryString.endIndex])
                            Text(prefix)
                            Text(match).foregroundColor(.white)
                            Text(suffix)
                                .lineLimit(1)
                        } else {
                            Text(cityStateCountryString)
                        }
                        Spacer()
                    }
                }
            }
        }
        .foregroundColor(.gray)
        //        .frame(minWidth: UIScreen.main.bounds.width)
    }
}

