//
//  AddClaveView.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import SwiftUI

enum TipoClave{
    case valor
    case usuarioContrasena
}

struct AddClaveView: View {
    
    @State var titulo: String = ""
    @State var valor: String = ""
    @State var usuario: String = ""
    @State var contrasena: String = ""
    @State var tipoClave: TipoClave = .valor
    
    @State var valorSeleccionado: Bool = true
    @State var usuarioContrasenaSeleccionado: Bool = false
    
    @Binding var showAddClave: Bool
    
    var body: some View {
        ZStack{
            Color.grisTransparente
                .onTapGesture {
                    showAddClave = false
                }
            VStack{
                VStack{
                    Text("anadirClave".localized)
                        .titulo(color: .negro)
                    TextField("titulo".localized, text: $titulo)
                        .modifier(CustomEditText(imagen: "titulo_icon"))
                        .padding([.leading, .trailing])
                    HStack{
                        Button(action: {
                            valorSeleccionado = true
                            usuarioContrasenaSeleccionado = false
                        }){EmptyView()}.buttonStyle(BotonCambiante(texto: "soloUsuario".localized, seleccionado: $valorSeleccionado))
                        .padding(4)
                        Button(action: {
                            valorSeleccionado = false
                            usuarioContrasenaSeleccionado = true
                        }){EmptyView()}.buttonStyle(BotonCambiante(texto: "usuarioYcontrasena".localized, seleccionado: $usuarioContrasenaSeleccionado))
                        .padding(4)
                    }
                    .padding()
                    if valorSeleccionado{
                        TextField("usuario".localized, text: $valor)
                            .modifier(CustomEditText(imagen: "valor_icon"))
                            .padding([.leading, .trailing])
                    } else {
                        TextField("usuario".localized, text: $usuario)
                            .modifier(CustomEditText(imagen: "person_icon"))
                            .padding([.leading, .trailing])
                        TextField("pass".localized, text: $contrasena)
                            .modifier(CustomEditText(imagen: "pass_icon"))
                            .padding([.leading, .trailing])
                    }
                    Button(action: {
                        if puedeGuardarClave(){
                            if valorSeleccionado{
                                ClavesManager().guardarClave(token: ClavesManager().generarToken(),
                                                             tokenUsuario: getUsuario().token,
                                                             titulo: titulo,
                                                             valor: valor,
                                                             usuario: "",
                                                             contrasena: "",
                                                             fecha: Data().description)
                            } else {
                                ClavesManager().guardarClave(token: ClavesManager().generarToken(),
                                                             tokenUsuario: getUsuario().token,
                                                             titulo: titulo,
                                                             valor: "",
                                                             usuario: usuario,
                                                             contrasena: contrasena,
                                                             fecha: Data().description)
                            }
                            showAddClave = false
                        }
                    }){EmptyView()}.buttonStyle(BotonPrincipal(text: "guardar".localized, enabled: puedeGuardarClave()))
                        .padding()
                    
                }
                .padding()
                .background(Color.blanco)
                .cornerRadius(10)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
    
    func puedeGuardarClave() -> Bool{
        return !titulo.isEmpty && (!valor.isEmpty || (!usuario.isEmpty && !contrasena.isEmpty))
    }
}
