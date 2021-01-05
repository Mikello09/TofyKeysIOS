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
    @Binding var showTeclado: Bool
    
    var body: some View {
        ZStack{
            Color.grisTransparente
            VStack{
                VStack{
                    Image("pin_icon")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .padding(8)
                    Text("introduceCodigoPin".localized)
                        .titulo(color: .negro)
                        .padding(.bottom, 8)
                    VStack{
                        Text(pinValor)
                            .titulo(color: .principal)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 30)
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
                            EmptyView()
                            DigitoTeclado("0")
                            EmptyView()
                        }
                        .frame(height: 80)
                        HStack{
                            Spacer()
                            Text("Cerrar")
                                .error()
                                .onTapGesture {
                                    self.showTeclado = false
                                }
                        }
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
                error = "pinIncorrecto".localized
            }
        }
    }
    
    func DigitoTeclado(_ digito: String) -> AnyView{
        return AnyView(
            VStack{
                Text(digito)
                    .titulo(color: .negro)
            }
            .frame(width: 36)
            .frame(height: 36)
            .padding()
            .background(Color.blanco)
            .cornerRadius(3)
            .shadow(radius: 3)
            .onTapGesture {
                error = ""
                self.pinValor.append(digito)
                pinCompleto()
            }
        )
    }
}
