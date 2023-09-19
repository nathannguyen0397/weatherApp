//
//  TabViewBottom.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 8/30/23.
//

import SwiftUI
struct TabViewBottom: View {
    @EnvironmentObject var viewModelWeather: ViewModelWeather
    @Binding var isMapShown: Bool
    var body: some View {
        VStack(spacing: 0){
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 0.5)
            HStack{
                HStack{
                    Button {
                        //Open the map
                        isMapShown = true
                    } label: {
                        Image(systemName: "map")
                            .resizable()
                            .frame(width: 25, height: 20)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "location.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                        ForEach(0..<5) { _ in
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white).opacity(0.5)
                                .padding(2)
                        }
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 7, height: 7)
                            .foregroundColor(.white).opacity(0.5)
                            .padding(2)
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 4, height: 4)
                            .foregroundColor(.white).opacity(0.5)
                            .padding(2)
                    }
                    Spacer()
                    NavigationLink(destination: SearchView()){
                        Image(systemName: "list.bullet")
                            .resizable()
                            .frame(width: 25, height: 20)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 40)
                Spacer()
            }
            .frame(height: 100, alignment: .topLeading)
            .background(.blue.opacity(0.2))
        }
        .transaction { transaction in //Disable any unexpected animations performing on the view
            transaction.animation = nil
        }
    }
}

struct TabViewBottom_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack() {
            ZStack{
                Color.black
                TabViewBottom(isMapShown: .constant(false))
            }
        }
        .environmentObject(ViewModelWeather())
    }
}


