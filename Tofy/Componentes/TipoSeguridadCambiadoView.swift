//
//  TipoSeguridadCambiadoView.swift
//  Tofy
//
//  Created by usuario on 30/12/20.
//

import SwiftUI

struct TipoSeguridadCambiadoView: View {
    
    @Binding var showTipoSeguridadCambiado: Bool
    var aceptar: ()->()
    var tipoSeguridad: TipoSeguridad
    
    var body: some View {
        ZStack{
            Color.grisTransparente
            VStack{
                VStack{
                    Text(tipoSeguridad.mensaje())
                        .titulo(color: .negro)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding()
                    if tipoSeguridad != .ninguna{
                        Image(tipoSeguridad.imagen())
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                    HStack{
                        Button(action: {
                            aceptar()
                            showTipoSeguridadCambiado = false
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
}
