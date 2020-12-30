//
//  PinTecladoView.swift
//  Tofy
//
//  Created by usuario on 26/12/20.
//

import SwiftUI

struct PinTecladoView: View {
    
    @State var pinValor: String = ""
    @State var error: String = ""
    
    var usuarioAutorizado: () -> ()
    
    var body: some View {
        ZStack{
            Color.grisTransparente
            VStack{
                VStack{
                    Text("Introduce tu código PIN")
                        .titulo(color: .negro)
                    VStack{
                        Text(pinValor)
                            .titulo(color: .principal)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 48)
                    .padding()
                    .background(Color.blanco)
                    .cornerRadius(3)
                    .shadow(radius: 3)
                    .overlay(RoundedRectangle(cornerRadius: 3.0).stroke(Color.principal, lineWidth: 1))
                    
                    Text(error)
                        .error()
                        .padding([.leading,.trailing])
                    
                    VStack{
                        HStack{
                            DigitoTeclado("1")
                            DigitoTeclado("2")
                            DigitoTeclado("3")
                        }
                        .frame(height: 80)
                        HStack{
                            DigitoTeclado("4")
                            DigitoTeclado("5")
                            DigitoTeclado("6")
                        }
                        .frame(height: 80)
                        HStack{
                            DigitoTeclado("7")
                            DigitoTeclado("8")
                            DigitoTeclado("9")
                        }
                        .frame(height: 80)
                        HStack{
                            DigitoTeclado("")
                            DigitoTeclado("0")
                            DigitoTeclado("")
                        }
                        .frame(height: 80)
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
    
    func pinCompleto(){
        if pinValor.count == 4{
            if pinValor == getUsuario().pin{
                usuarioAutorizado()
            } else {
                pinValor = ""
                error = "Pin incorrecto"
            }
        }
    }
    
    func DigitoTeclado(_ digito: String) -> AnyView{
        return AnyView(
            VStack{
                Text(digito)
                    .titulo(color: .negro)
            }
            .frame(width: 48)
            .frame(height: 48)
            .padding()
            .background(Color.blanco)
            .cornerRadius(3)
            .shadow(radius: 3)
            .overlay(RoundedRectangle(cornerRadius: 3.0).stroke(Color.principal, lineWidth: 1))
            .onTapGesture {
                error = ""
                self.pinValor.append(digito)
                pinCompleto()
            }
        )
    }
}
