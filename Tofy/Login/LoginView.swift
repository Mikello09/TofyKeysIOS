//
//  LoginView.swift
//  Tofy
//
//  Created by usuario on 02/12/2020.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    @State var tipoSeguridad: TipoSeguridad?
    
    @State var emailText: String = ""
    @State var passText: String = ""
    @State var errorValue: String = ""
    
    @State var goToRegistro: Bool = false
    @State var showPinTeclado: Bool = false
    @State var showBiometria: Bool = false
    @State var goToClaves: Bool = false
    @State var showUnLock: Bool = false
    
    @State var showLoader: Bool = false
    
    var body: some View {
        NavigationView{
            BaseView(showLoader: $showLoader, content:
                    ZStack{
                        VStack{
                            Text("appName".localized)
                                .titulo(color: Color.principal)
                                .padding()
                            
                            TextField("email".localized, text: $emailText)
                                .modifier(CustomEditText(imagen: "person_icon"))
                            .padding()
                            
                            TextField("pass".localized, text: $passText)
                                .modifier(CustomEditText(imagen: "pass_icon"))
                            .padding([.leading, .trailing])
                            HStack{
                                Text(errorValue)
                                    .error()
                                Spacer()
                            }
                            .padding([.leading, .trailing])
                            
                            Button(action: {
                                if isEntrarEnabled(){
                                    showLoader = true
                                    errorValue = ""
                                    viewModel.entrar(email: emailText, contrasena: passText)
                                }
                            }){EmptyView()}.buttonStyle(BotonPrincipal(text: "entrar".localized, enabled: self.isEntrarEnabled()))
                            .padding()
                            Spacer()
                            Text("noTienesCuenta".localized)
                                .boton()
                                .padding()
                                .onTapGesture {
                                    goToRegistro.toggle()
                                }
                            Group{
                                NavigationLink(destination: RegistroView(), isActive: $goToRegistro){EmptyView()}
                                NavigationLink(destination: ClavesView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext), isActive: $goToClaves){EmptyView()}
                            }
                        }
                        if showPinTeclado{
                            PinTecladoView(usuarioAutorizado: usuarioAutorizado)
                        }
                        if showUnLock{
                            LottieView(name: "unlock", play: .constant(1), loopMode: .playOnce, loopFinished: unlockAnimationTerminado)
                                .frame(width: 200, height: 200)
                        }
                    })
        }
        .navigationBarHidden(true)
        .onAppear{
            self.viewModel.iniciarApp()
        }
        .onReceive(self.viewModel.$tipoSeguridad){ value in
            if let tipo = value{
                switch tipo {
                case .ninguna:
                    goToClaves = true
                case .pin:
                    showPinTeclado = true
                case .biometria:
                    print("todo")
                }
            }
        }
        .onReceive(viewModel.$errorEntrar){ value in
            if let error = value{
                showLoader = false
                self.errorValue = error.reason
            }
        }
        .onReceive(viewModel.$usuarioValidado){ value in
            if let _ = value{
                showLoader = false
                goToClaves = true
            }
        }
    }
    
    func isEntrarEnabled() -> Bool{
        return !emailText.isEmpty && !passText.isEmpty
    }
    
    func usuarioAutorizado(){
        showPinTeclado = false
        showUnLock = true
    }
    
    func unlockAnimationTerminado(){
        goToClaves = true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
