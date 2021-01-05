//
//  TipoSeguridadCambiadoView.swift
//  Tofy
//
//  Created by usuario on 30/12/20.
//

import SwiftUI

struct InformacionPopUpView: View {
    
    @Binding var showInformacionPopUp: Bool
    var aceptar: (()->())?
    var texto: String
    var imagen: String
    
    var body: some View {
        ZStack{
            Color.grisTransparente
            VStack{
                VStack{
                    Text(texto)
                        .titulo(color: .negro)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding()
                    Image(imagen)
                        .resizable()
                        .frame(width: 48, height: 48)
                    HStack{
                        Button(action: {
                            accion()
                            showInformacionPopUp = false
                        }){EmptyView()}.buttonStyle(BotonConColor(color: .principal, texto: "aceptar".localized))
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
    
    func accion(){
        if let accionAceptar = aceptar{
            accionAceptar()
        }
    }
}
