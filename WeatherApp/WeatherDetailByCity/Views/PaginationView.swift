//
//  PaginationView.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/15/23.
//

import SwiftUI

struct PaginationView: View {
    var body: some View {
        
        HStack{
            HStack{
                Image(systemName: "map")
                    .resizable()
                    .frame(width: 25, height: 20)
                    .foregroundColor(.white)
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
                NavigationLink(destination: WeatherSearchByCityView()){
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
        .frame(width: .infinity, height: 100, alignment: .topLeading)
        .background(Color(hex: "#2773b9")).opacity(0.8)
    }
}

struct PaginationView_Previews: PreviewProvider {
    static var previews: some View {
        PaginationView()
    }
}
