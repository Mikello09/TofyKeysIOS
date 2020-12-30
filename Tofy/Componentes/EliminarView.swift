//
//  EliminarView.swift
//  Tofy
//
//  Created by usuario on 29/12/20.
//

import SwiftUI

struct EliminarView: View {
    
    @Binding var showEliminarClave: Bool
    var clave: Clave
    var eliminarClave: () -> ()
    
    var body: some View {
        ZStack{
            Color.grisTransparente
                .onTapGesture {
                    showEliminarClave = false
                }
            VStack{
                VStack{
                    Text("¿Estás segur@ de eliminar la clave \(clave.titulo ?? "")?")
                        .titulo(color: .negro)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding()
                    HStack{
                        Button(action: {
                            eliminarClave()
                            showEliminarClave = false
                        }){EmptyView()}.buttonStyle(BotonConColor(color: .rojo, texto: "SI"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        Button(action: {
                            showEliminarClave = false
                        }){EmptyView()}.buttonStyle(BotonConColor(color: .verde, texto: "NO"))
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
