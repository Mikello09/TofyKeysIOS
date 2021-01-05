//
//  RegistroView.swift
//  Tofy
//
//  Created by usuario on 24/12/20.
//

import SwiftUI

struct RegistroView: View {
    
    @ObservedObject var viewModel: RegistroViewModel = RegistroViewModel()
    
    @State var email: String = ""
    @State var contrasena1: String = ""
    @State var contrasena2: String = ""
    
    @State var errorTexto: String = ""
    
    @State var goToConfigurarPin: Bool = false
    
    @State var showLoader: Bool = false
    
    
    var body: some View {
        BaseView(showLoader: $showLoader, content:
            VStack{
                InfoView(texto: "registroInfo".localized)
                    .padding()
                
                TextField("email".localized, text: $email)
                .modifier(CustomEditText(imagen: "person_icon"))
                .padding([.leading, .trailing])
                
                SecureField("pass".localized, text: $contrasena1)
                .modifier(CustomEditText(imagen: "pass_icon"))
                .padding([.leading, .trailing, .top])
                
                SecureField("repetirPass".localized, text: $contrasena2)
                .modifier(CustomEditText(imagen: "pass_icon"))
                .padding([.leading, .trailing, .top])
                
                HStack{
                    Text(errorTexto)
                        .error()
                    Spacer()
                }
                .padding([.leading, .trailing])
                
                Button(action: {
                    if camposCompletos(){
                        showLoader = true
                        self.viewModel.registrar(email: email, contrasena1: contrasena1, contrasena2: contrasena2)
                    }
                }){EmptyView()}.buttonStyle(BotonPrincipal(text: "continuar".localized, enabled: camposCompletos()))
                .padding()
                Spacer()
                Group{
                    NavigationLink(destination: ConfigurarPinView(), isActive: $goToConfigurarPin){}
                }
            }, titulo: "Registro"
        )
        .onReceive(self.viewModel.$error){ value in
            if let error = value{
                showLoader = false
                errorTexto = error
            }
        }
        .onReceive(self.viewModel.$registrado){ value in
            if let _ = value{
                showLoader = false
                goToConfigurarPin = true
            }
        }
    }
    
    func camposCompletos() -> Bool{
        return !email.isEmpty || !contrasena1.isEmpty || !contrasena2.isEmpty
    }
}

struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView()
    }
}
