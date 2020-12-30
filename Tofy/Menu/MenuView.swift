//
//  MenuView.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import SwiftUI

struct MenuView: View {
    
    @State var showLoader: Bool = false
    
    @State var cerrarSesion: Bool = false
    @State var goToSeguridad: Bool = false
    @State var goToAppInfo: Bool = false
    
    @State var showCerrarSesion: Bool = false
    
    var body: some View {
        BaseView(showLoader: $showLoader,
                 content:
                    ZStack{
                        VStack{
                            VStack{
                                HStack{
                                    Text("seguridad".localized)
                                        .titulo(color: .blanco)
                                        .padding()
                                    Spacer()
                                    Image("lock_icon")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .padding()
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(Color.principal)
                                .cornerRadius(3)
                                .shadow(radius: 3)
                                .padding(8)
                                .onTapGesture {
                                    self.goToSeguridad = true
                                }
                                HStack{
                                    Text("appInfo".localized)
                                        .titulo(color: .blanco)
                                        .padding()
                                    Spacer()
                                    Image("info_icon")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .padding()
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(Color.principal)
                                .cornerRadius(3)
                                .shadow(radius: 3)
                                .padding(8)
                                .onTapGesture {
                                    self.goToAppInfo = true
                                }
                            }
                            .padding()
                            Spacer()
                            HStack{
                                Spacer()
                                Text("cerrarSesion".localized)
                                    .titulo(color: .rojo)
                                    .padding()
                                    .onTapGesture {
                                        showCerrarSesion = true
                                    }
                            }
                            Group{
                                NavigationLink(destination: LoginView(), isActive: $cerrarSesion){EmptyView()}
                                NavigationLink(destination: SeguridadView(), isActive: $goToSeguridad){EmptyView()}
                            }
                        }
                        if showCerrarSesion{
                            CerrarSesionView(cerrarSesion: cerrarSesionAction, showCerrarSesion: $showCerrarSesion)
                        }
                    }
                    ,
                 titulo: "Menú")
    }
    
    func cerrarSesionAction(){
        eliminarUsuario()
        ClavesManager().eliminarTodasLasClaves()
        cerrarSesion = true
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
