//
//  ClavesView.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import SwiftUI

struct ClavesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: ClavesViewModel = ClavesViewModel()
    
    @State var showLoader: Bool = false
    
    @State var goToMenu: Bool = false
    
    @State var anadirClave: Bool = false
    @State var detalleClave: Bool = false
    @State var eliminarClave: Bool = false
    @State var showEliminarError: Bool = false
    @State var errorEliminarMensaje: String = ""
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
                            .frame(height: UIScreen.main.bounds.height)
                        VStack(spacing: 8){
                            HStack{
                                Text("\("hola".localized) \(getUsuario().email)")
                                    .titulo(color: .principal)
                                    .padding([.top,.leading, .trailing])
                                    .padding(.top)
                                Spacer()
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
                                    .padding([.leading, .trailing, .top])
                                    .padding(.top)
                                }
                            } else {
                                VStack{
                                    InfoView(texto: "Añade claves para empezar a utilizar Tofy Keys")
                                }
                                .padding()
                            }
                            //Spacer()
                            ZStack(alignment: .center){
                                HStack{
                                    Spacer()
                                    Image("menu_icon")
                                        .resizable()
                                        .frame(width: 48, height: 48)
                                        .padding(.trailing)
                                        .onTapGesture {
                                            goToMenu = true
                                        }
                                }
                                Button(action: {
                                    anadirClave = true
                                }){EmptyView()}
                                .buttonStyle(BotonCircular())
                            }
                            .frame(height: 80)
                            .padding(.bottom)
                        }
                        
                        if anadirClave{
                            AddClaveView(showAddClave: $anadirClave)
                        }
                        if detalleClave{
                            DetalleClaveView(showDetalleClave: $detalleClave,
                                             clave: claveSeleccionada ?? Clave(),
                                             eliminar: eliminarAccion)
                        }
                        if eliminarClave{
                            EliminarView(showEliminarClave: $eliminarClave,
                                         clave: claveSeleccionada ?? Clave(),
                                         eliminarClave: eliminarClaveLocal)
                        }
                        if showEliminarError{
                            InformacionPopUpView(showInformacionPopUp: $showEliminarError,
                                                 texto: errorEliminarMensaje,
                                                 imagen: "no_sincronizado")
                        }
                        
                        Group{
                            NavigationLink(destination: MenuView(cerrarSesionAccion: cerrarSesionAccion), isActive: $goToMenu){EmptyView()}
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
        .onReceive(self.viewModel.$errorEliminandoClave){ value in
            if let error = value{
                errorEliminarMensaje = error
                showEliminarError = true
            }
        }
    }
    
    func eliminarAccion(){
        detalleClave = false
        eliminarClave = true
    }
    
    func eliminarClaveLocal(){
        viewModel.eliminarClave(clave: claveSeleccionada ?? Clave())
    }
    
    func cerrarSesionAccion(){
        eliminarUsuario()
        ClavesManager().eliminarTodasLasClaves()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ClavesView_Previews: PreviewProvider {
    static var previews: some View {
        ClavesView()
    }
}
