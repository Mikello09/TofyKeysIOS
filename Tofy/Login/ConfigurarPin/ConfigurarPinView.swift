//
//  ConfigurarPinView.swift
//  Tofy
//
//  Created by usuario on 26/12/20.
//

import SwiftUI

struct ConfigurarPinView: View {
    
    @State var goToPantallaPin: Bool = false
    @State var goToClaves: Bool = false
    
    @State var showLoader: Bool = false
    
    var body: some View {
        BaseView(
            showLoader: $showLoader,
            content:
                VStack{
                    InfoView(texto: "configurarPinInfo".localized)
                        .padding()
                    Button(action: {
                        self.goToPantallaPin = true
                    }){EmptyView()}.buttonStyle(BotonPrincipal(text: "configurarAhora".localized, enabled: true))
                    .padding()
                    Text("masTarde".localized).boton()
                        .padding()
                        .onTapGesture {
                            self.goToClaves = true
                        }
                    Spacer()
                    Group{
                        NavigationLink(destination: PinView(), isActive: $goToPantallaPin){EmptyView()}
                        NavigationLink(destination: ClavesView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext), isActive: $goToClaves){EmptyView()}
                    }
                },
            titulo: "Configurar PIN")
    }
}

struct ConfigurarPinView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurarPinView()
    }
}
