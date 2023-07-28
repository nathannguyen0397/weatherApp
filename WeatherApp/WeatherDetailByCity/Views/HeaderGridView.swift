//
//  HeaderGridView.swift
//  Weather
//
//  Created by Ngoc Nguyen on 6/15/23.
//

import SwiftUI

struct HeaderGridView: View {
    var body: some View {
        VStack {
            Text("Cupertino")
                .foregroundColor(.white)
                .font(.system(size: 40))
                .padding(.top, 50)
            //  .aspectRatio(contentMode: .fit)
            HStack{
                
                Text("70°")
                    .foregroundColor(.white)
                Text("|")
                    .foregroundColor(.white).opacity(0.5)
                    .frame(width: 10)
                Text("Sunny")
                    .foregroundColor(Color(hex: "#b7f3fb"))
            }
            .font(.system(size: 20, weight: .medium))
            
        }
    }
}

struct HeaderGridView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderGridView()
    }
}
