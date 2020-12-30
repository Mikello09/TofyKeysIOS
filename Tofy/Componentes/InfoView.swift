//
//  InfoView.swift
//  Tofy
//
//  Created by usuario on 24/12/20.
//

import SwiftUI

struct InfoView: View {
    
    var texto: String
    
    var body: some View {
        VStack{
            HStack{
                Image("tofy_icon")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading)
                Spacer()
            }
            Text(texto)
                .info()
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blanco)
        .cornerRadius(3)
        .shadow(radius: 3)
        //.overlay(RoundedRectangle(cornerRadius: 3.0).stroke(Color.principal, lineWidth: 1))
    }
}


