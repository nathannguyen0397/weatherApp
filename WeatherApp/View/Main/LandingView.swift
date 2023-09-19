//
//  LandingView.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 8/28/23.
//

import SwiftUI

struct LandView: View {
    @State private var zAxisRotation = false
    @Binding var isShown : Bool
    @State private var opacityLandView: Double = 1
    var body: some View {
        ZStack {
            // Background color or image
            LinearGradient(colors: [.blue, Color(red: 0.4627, green: 0.8392, blue: 1.0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack {
                ZStack {  // RotatingSun
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.yellow)
                        .rotationEffect(.degrees(zAxisRotation ? 360 : 0), anchor: .center)
                        .offset(x: 50, y: -50)
                        .onAppear() {
                            withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                                self.zAxisRotation.toggle()
                            }
                        }
                        .overlay{
                            // Cloud
                            Image(systemName: "cloud.fill")
                                .resizable()
                                .frame(width: 250, height: 150)
                                .foregroundColor(.white.opacity(0.8))
                                .offset(x: -25)
                            
                        }
                }
            }
        }
        .opacity(opacityLandView)
        .onAppear(){
            withAnimation(Animation.linear(duration: 1.5).delay(1.5)) {
                opacityLandView = 0
            }
            //remove the view after it fades
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                isShown = false
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        LandView(isShown: .constant(true))
//    }
//}
