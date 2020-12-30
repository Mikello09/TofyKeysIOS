//
//  DetalleClaveView.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import SwiftUI

struct DetalleClaveView: View {
    
    @Binding var showDetalleClave: Bool
    @State var editando: Bool = false
    
    var clave: Clave
    var eliminar: ()->()
    
    @State var tituloEditado: String = ""
    @State var valorEditado: String = ""
    @State var usuarioEditado: String = ""
    @State var contrasenaEditado: String = ""
    
    var body: some View {
        ZStack{
            Color.grisTransparente
                .onTapGesture {
                    showDetalleClave = false
                }
            VStack{
                VStack{
                    if editando{
                        Text("Editar clave")
                            .titulo(color: .negro)
                            .padding()
                        TextField("titulo".localized, text: $tituloEditado)
                            .modifier(CustomEditText(imagen: "titulo_icon"))
                            .padding([.leading, .trailing])
                        if clave.valor != ""{
                            TextField("usuario".localized, text: $valorEditado)
                                .modifier(CustomEditText(imagen: "valor_icon"))
                                .padding([.leading, .trailing])
                        } else {
                            TextField("usuario".localized, text: $usuarioEditado)
                                .modifier(CustomEditText(imagen: "person_icon"))
                                .padding([.leading, .trailing])
                            TextField("pass".localized, text: $contrasenaEditado)
                                .modifier(CustomEditText(imagen: "pass_icon"))
                                .padding([.leading, .trailing])
                        }
                        Button(action: {
                            if puedeActualizar(){
                                if clave.valor != ""{
                                    ClavesManager().actualizarValor(clave: clave,
                                                                    titulo: tituloEditado,
                                                                    valor: valorEditado)
                                } else{
                                    ClavesManager().actualizarUsuarioContrasena(clave: clave,
                                                                                titulo: tituloEditado,
                                                                                usuario: usuarioEditado,
                                                                                contrasena: contrasenaEditado)
                                }
                                showDetalleClave = false
                            }
                        }){EmptyView()}.buttonStyle(BotonPrincipal(text: "actualizar".localized, enabled: puedeActualizar()))
                        .padding(.top)
                    } else {
                        VStack{
                            Spacer()
                            Text(clave.titulo ?? "")
                                .titulo(color: .blanco)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .background(Color.principal)
                        if clave.valor != ""{
                            Text(clave.valor ?? "")
                                .titulo(color: .negro)
                                .padding()
                        } else {
                            Text(clave.usuario ?? "")
                                .titulo(color: .negro)
                                .padding()
                            Divider()
                                .background(Color.negro)
                            Text(clave.contrasena ?? "")
                                .titulo(color: .negro)
                                .padding()
                        }
                        HStack{
                            Button(action: {
                                eliminar()
                            }){EmptyView()}.buttonStyle(BotonConColor(color: .rojo, texto: "eliminar".localized))
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            Button(action: {
                                editando = true
                            }){EmptyView()}.buttonStyle(BotonConColor(color: .verde, texto: "editar".localized))
                            .frame(maxWidth: .infinity)
                            .padding(8)
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
        .onAppear{
            tituloEditado = clave.titulo ?? ""
            valorEditado = clave.valor ?? ""
            usuarioEditado = clave.usuario ?? ""
            contrasenaEditado = clave.contrasena ?? ""
        }
    }
    
    func puedeActualizar() -> Bool{
        if clave.valor != ""{
            return !tituloEditado.isEmpty && !valorEditado.isEmpty
        } else {
            return !tituloEditado.isEmpty && !usuarioEditado.isEmpty && !contrasenaEditado.isEmpty
        }
    }
}
