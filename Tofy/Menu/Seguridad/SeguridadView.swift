//
//  SeguridadView.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import SwiftUI

struct SeguridadView: View {
    
    @ObservedObject var viewModel: SeguridadViewModel = SeguridadViewModel()
    
    @State var showLoader: Bool = false
    @State var goToConfigurarPin: Bool = false
    @State var goToClaves: Bool = false
    @State var tipoSeguridad: TipoSeguridad = .ninguna
    @State var tipoBiometria: TipoBiometria = .ninguna
    @State var showCambioSeguridad: Bool = false
    
    var body: some View {
        BaseView(showLoader: $showLoader,
                 content:
                    ZStack{
                        VStack{
                            VStack{
                                HStack{
                                    ZStack{
                                        Circle()
                                            .fill(Color.gris)
                                            .frame(width: 24, height: 24)
                                            .padding()
                                        if tipoSeguridad == .ninguna{
                                            Circle()
                                                .fill(Color.principal)
                                                .frame(width: 16, height: 16)
                                                .padding()
                                        }
                                    }
                                    Text("ninguna".localized)
                                        .info()
                                    Spacer()
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.blanco)
                                .cornerRadius(3)
                                .shadow(radius: 3)
                                .onTapGesture {
                                    tipoSeguridad = .ninguna
                                }
                            }
                            .padding()
                            VStack{
                                HStack{
                                    ZStack{
                                        Circle()
                                            .fill(Color.gris)
                                            .frame(width: 24, height: 24)
                                            .padding()
                                        if tipoSeguridad == .pin{
                                            Circle()
                                                .fill(Color.principal)
                                                .frame(width: 16, height: 16)
                                                .padding()
                                        }
                                    }
                                    Text("pin".localized)
                                        .info()
                                    Spacer()
                                    Image("pin_icon")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .padding()
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.blanco)
                                .cornerRadius(3)
                                .shadow(radius: 3)
                                .onTapGesture {
                                    tipoSeguridad = .pin
                                }
                            }
                            .padding([.leading, .trailing])
                            if tipoBiometria != .ninguna{
                                VStack{
                                    HStack{
                                        ZStack{
                                            Circle()
                                                .fill(Color.gris)
                                                .frame(width: 24, height: 24)
                                                .padding()
                                            if tipoSeguridad == .biometria{
                                                Circle()
                                                    .fill(Color.principal)
                                                    .frame(width: 16, height: 16)
                                                    .padding()
                                            }
                                        }
                                        Text(tipoBiometria.titulo())
                                            .info()
                                        Spacer()
                                        Image(tipoBiometria.icono())
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                            .padding()
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.blanco)
                                    .cornerRadius(3)
                                    .shadow(radius: 3)
                                    .onTapGesture {
                                        tipoSeguridad = .biometria
                                    }
                                }
                                .padding()
                            }
                            Spacer()
                            if isBotonVisible(){
                                Button(action: {
                                    switch tipoSeguridad{
                                    case .ninguna:
                                        guardarTipoSeguridad(tipo: .ninguna)
                                        showCambioSeguridad = true
                                    case .pin:
                                        goToConfigurarPin = true
                                    case .biometria:
                                        guardarTipoSeguridad(tipo: .biometria)
                                        showCambioSeguridad = true
                                    }
                                }){EmptyView()}.buttonStyle(BotonPrincipal(text: textoBoton(), enabled: true))
                                .padding()
                            }
                            Group{
                                NavigationLink(destination: PinView(), isActive: $goToConfigurarPin){EmptyView()}
                                NavigationLink(destination: ClavesView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext), isActive: $goToClaves){EmptyView()}
                            }
                        }
                        if showCambioSeguridad{
                            InformacionPopUpView(showInformacionPopUp: $showCambioSeguridad,
                                                 aceptar: aceptar,
                                                 texto: tipoSeguridad.mensaje(tipoBiometria: tipoBiometria),
                                                 imagen: tipoSeguridad.imagen(tipoBiometria: tipoBiometria))
                        }
                    }
                    ,
                 titulo: "Seguridad")
            .onAppear{
                self.viewModel.obtenerTipoSeguridad()
                self.viewModel.obtenerTipoBiometria()
            }
            .onReceive(self.viewModel.$tipoSeguridad){ value in
                if let tipo = value{
                    tipoSeguridad = tipo
                }
            }
            .onReceive(self.viewModel.$tipoBiometria){ value in
                if let biometria = value{
                    tipoBiometria = biometria
                }
            }
    }
    func textoBoton() -> String{
        switch tipoSeguridad {
        case .ninguna:
            return "guardar".localized
        case .pin:
            return "nuevoPinBoton".localized
        case .biometria:
            return "guardar".localized
        }
    }
    
    func isBotonVisible() -> Bool{
        return tipoSeguridad != getUsuario().tipoSeguridad
    }
    
    func aceptar(){
        goToClaves = true
    }
}

struct SeguridadView_Previews: PreviewProvider {
    static var previews: some View {
        SeguridadView()
    }
}
