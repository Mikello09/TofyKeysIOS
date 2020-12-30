//
//  PinConfiguradoView.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import SwiftUI

struct PinConfiguradoView: View {
    
    @State var showLoader: Bool = false
    @State var goToClaves: Bool = false
    
    var body: some View {
        BaseView(showLoader: $showLoader,
                 content:
                    VStack{
                        LottieView(name: "lock", play: .constant(1), loopMode: .playOnce, loopFinished: animationFinished)
                            .frame(width: 200, height: 200)
                            .padding(.top, 64)
                        Text("PIN configurado correctamente")
                            .bold()
                            .padding()
                        Spacer()
                        Group{
                            NavigationLink(destination: ClavesView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext), isActive: $goToClaves){EmptyView()}
                        }
                    },
                 titulo: "PIN")
    }
    
    func animationFinished(){
        goToClaves = true
    }
}

struct PinConfiguradoView_Previews: PreviewProvider {
    static var previews: some View {
        PinConfiguradoView()
    }
}
