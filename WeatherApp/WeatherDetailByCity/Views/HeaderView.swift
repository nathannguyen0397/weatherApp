//
//  HeaderView.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/15/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            Text("Cupertino")
                .foregroundColor(.white)
                .font(.system(size: 40))
                .padding(.top, 50)
            //  .aspectRatio(contentMode: .fit)
            Text("70°")
                .font(.system(size: 100, weight: .thin))
                .foregroundColor(.white)
            Text("Sunny")
                .font(.system(size: 28))
                .foregroundColor(Color(hex: "#b7f3fb"))
            Text("H:76°  L:51°")
                .font(.system(size: 24))
                .foregroundColor(.white).opacity(0.5)
            Spacer().frame(height: 30)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
