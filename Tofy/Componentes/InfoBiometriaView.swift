//
//  InfoBiometriaView.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import SwiftUI

struct InfoBiometriaView: View {
    
    @Binding var biometriaActiva: Bool
    
    var body: some View {
        VStack{
            HStack{
                Image("tofy_icon")
                    .resizable()
                    .frame(width: 24, height: 24)
                Spacer()
            }
            Text("biometriaInfo".localized)
                .info()
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            HStack{
                Text("activarBiometria".localized)
                    .bold()
                Spacer()
                Toggle(isOn: $biometriaActiva){EmptyView()}
                    .frame(maxWidth: 60)
                    .toggleStyle(SwitchToggleStyle(tint: .principal))
                    .padding()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blanco)
        .cornerRadius(3)
        .shadow(radius: 3)
        //.overlay(RoundedRectangle(cornerRadius: 3.0).stroke(Color.principal, lineWidth: 1))
    }
}
