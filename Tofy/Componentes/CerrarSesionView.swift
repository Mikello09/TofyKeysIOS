//
//  CerrarSesionView.swift
//  Tofy
//
//  Created by usuario on 30/12/20.
//

import SwiftUI

struct CerrarSesionView: View {
    
    var cerrarSesion: ()->()
    @Binding var showCerrarSesion: Bool
    
    var body: some View {
        ZStack{
            Color.grisTransparente
            VStack{
                VStack{
                    Text("cerrrarSesionTexto".localized)
                        .titulo(color: .negro)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding()
                    HStack{
                        Button(action: {
                            cerrarSesion()
                            showCerrarSesion = false
                        }){EmptyView()}.buttonStyle(BotonConColor(color: .rojo, texto: "si".localized))
                        .frame(maxWidth: .infinity)
                        .padding()
                        Button(action: {
                            showCerrarSesion = false
                        }){EmptyView()}.buttonStyle(BotonConColor(color: .verde, texto: "no".localized))
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
                .padding()
                .background(Color.blanco)
                .cornerRadius(10)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}
