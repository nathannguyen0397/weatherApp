//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 8/29/23.
//

import SwiftUI

struct BackgroundView: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .degrees(0)
    var body: some View {
        ZStack{
            //Background image ignoring safe area
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .saturation(1.5)
                .brightness(0.1)
                .overlay(content: {
                    Color(.yellow).opacity(0.1)
                })
                .scaleEffect(scale)
                .rotationEffect(rotation)
                .ignoresSafeArea()
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 15).repeatForever(autoreverses: true)) {
                        scale = 1.3
                        rotation = .degrees(9)
                    }
                }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
