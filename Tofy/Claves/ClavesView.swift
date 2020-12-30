//
//  ClavesView.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import SwiftUI

struct ClavesView: View {
    
    @ObservedObject var viewModel: ClavesViewModel = ClavesViewModel()
    
    @State var showLoader: Bool = false
    
    @State var goToMenu: Bool = false
    
    @State var anadirClave: Bool = false
    @State var detalleClave: Bool = false
    @State var eliminarClave: Bool = false
    @State var claveSeleccionada: Clave?
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Clave.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Clave.token, ascending: true)]
    )var claves: FetchedResults<Clave>
    
    var body: some View {
        BaseView(showLoader: $showLoader,
                 content:
                    ZStack{
                        Image("fondo_madera_claro")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        VStack{
                            HStack{
                                Spacer()
                                Image("menu_icon")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .padding()
                                    .padding(.top)
                                    .padding(.top)
                                    .onTapGesture {
                                        goToMenu = true
                                    }
                            }
                            if claves.count > 0{
                                ScrollView(.vertical, showsIndicators: false){
                                    VStack{
                                        ForEach(claves, id: \.titulo){ clave in
                                            HStack{
                                                Image("llave_icon")
                                                    .resizable()
                                                    .frame(width: 32, height: 32)
                                                    .padding()
                                                Text(clave.titulo ?? "")
                                                    .info()
                                                    .padding()
                                                Spacer()
                                                Image(clave.sincronizado ? "sincronizado" : "no_sincronizado")
                                                    .resizable()
                                                    .frame(width: 32, height: 32)
                                                    .padding()
                                            }
                                            .frame(height: 60)
                                            .padding()
                                            .background(Color.blanco)
                                            .shadow(radius: 3)
                                            .cornerRadius(3)
                                            .onTapGesture{
                                                claveSeleccionada = clave
                                                detalleClave = true
                                            }
                                        }
                                    }
                                    .padding([.leading, .trailing])
                                }
                            } else {
                                InfoView(texto: "Añade claves para empezar a utilizar Tofy Keys")
                                    .padding()
                            }
                            Spacer()
                            Button(action: {
                                anadirClave = true
                            }){EmptyView()}
                            .buttonStyle(BotonCircular())
                            .padding()
                            .padding(.bottom)
                        }
                        
                        if anadirClave{
                            AddClaveView(showAddClave: $anadirClave)
                        }
                        if detalleClave{
                            DetalleClaveView(showDetalleClave: $detalleClave, clave: claveSeleccionada ?? Clave(), eliminar: eliminarAccion)
                        }
                        if eliminarClave{
                            EliminarView(showEliminarClave: $eliminarClave, clave: claveSeleccionada ?? Clave(), eliminarClave: eliminarClaveLocal)
                        }
                        
                        Group{
                            NavigationLink(destination: MenuView(), isActive: $goToMenu){EmptyView()}
                        }
                    }
        )
        .onAppear{
            if claves.count > 0 {
                viewModel.sincronizarClavesLocales(claves: claves)
            } else {
                viewModel.getAllClaves()
            }
        }
    }
    
    func eliminarAccion(){
        detalleClave = false
        eliminarClave = true
    }
    
    func eliminarClaveLocal(){
        ClavesManager().eliminarClave(clave: claveSeleccionada ?? Clave())
    }
}

struct ClavesView_Previews: PreviewProvider {
    static var previews: some View {
        ClavesView()
    }
}
