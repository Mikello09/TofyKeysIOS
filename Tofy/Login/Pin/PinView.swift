//
//  PinView.swift
//  Tofy
//
//  Created by usuario on 26/12/20.
//

import SwiftUI

struct PinView: View {
    
    @ObservedObject var viewModel: PinViewModel = PinViewModel()
    
    @State var digito1Texto: String = ""
    @State var digito1Valor: String = ""
    @State var isDigito1Responder: Bool? = true
    
    @State var digito2Texto: String = ""
    @State var digito2Valor: String = ""
    @State var isDigito2Responder: Bool? = false
    
    @State var digito3Texto: String = ""
    @State var digito3Valor: String = ""
    @State var isDigito3Responder: Bool? = false
    
    @State var digito4Texto: String = ""
    @State var digito4Valor: String = ""
    @State var isDigito4Responder: Bool? = false
    
    //BIOMETRIA
    @State var tipoBiometria: TipoBiometria = .ninguna
    @State var biometriaActiva: Bool = false
    
    @State var showLoader: Bool = false
    
    @State var goToPinConfigurado: Bool = false
    
    var body: some View {
        BaseView(
            showLoader: $showLoader,
            content:
                VStack{
                    InfoView(texto: "pinViewInfo".localized)
                        .padding()
                    HStack{
                        PinTextField(text: $digito1Texto,
                                     valor: $digito1Valor,
                                     nextResponder: $isDigito2Responder,
                                     isResponder: $isDigito1Responder,
                                     isSecured: true,
                                     keyboard: .numberPad)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(3.0)
                            .shadow(color: self.isDigito1Responder ?? false ? Color.gris : Color.clear, radius: 5.0, x: self.isDigito1Responder ?? false ? 3.0 : 0, y: self.isDigito1Responder ?? false ? 3.0 : 0)
                            .border(Color.gris, width: self.isDigito1Responder ?? false ? 0 : 1)
                            .overlay(RoundedRectangle(cornerRadius: 3.0).stroke(Color.clear, lineWidth: 1))
                            .padding([.top,.bottom])
                            .padding([.leading, .trailing], 8)
                        
                        PinTextField(text: $digito2Texto,
                                     valor: $digito2Valor,
                                     nextResponder: $isDigito3Responder,
                                     isResponder: $isDigito2Responder,
                                     isSecured: true,
                                     keyboard: .numberPad)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(3.0)
                            .shadow(color: self.isDigito2Responder ?? false ? Color.gris : Color.clear, radius: 5.0, x: self.isDigito2Responder ?? false ? 3.0 : 0, y: self.isDigito2Responder ?? false ? 3.0 : 0)
                            .border(Color.gris, width: self.isDigito2Responder ?? false ? 0 : 1)
                            .overlay(RoundedRectangle(cornerRadius: 3.0).stroke(Color.clear, lineWidth: 1))
                            .padding([.top,.bottom])
                            .padding([.leading, .trailing], 8)
                        
                        PinTextField(text: $digito3Texto,
                                     valor: $digito3Valor,
                                     nextResponder: $isDigito4Responder,
                                     isResponder: $isDigito3Responder,
                                     isSecured: true,
                                     keyboard: .numberPad)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(3.0)
                            .shadow(color: self.isDigito3Responder ?? false ? Color.gris : Color.clear, radius: 5.0, x: self.isDigito3Responder ?? false ? 3.0 : 0, y: self.isDigito3Responder ?? false ? 3.0 : 0)
                            .border(Color.gris, width: self.isDigito3Responder ?? false ? 0 : 1)
                            .overlay(RoundedRectangle(cornerRadius: 3.0).stroke(Color.clear, lineWidth: 1))
                            .padding([.top,.bottom])
                            .padding([.leading, .trailing], 8)
                        
                        PinTextField(text: $digito4Texto,
                                     valor: $digito4Valor,
                                     nextResponder: .constant(nil),
                                     isResponder: $isDigito4Responder,
                                     isSecured: true,
                                     keyboard: .numberPad)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(3.0)
                            .shadow(color: self.isDigito4Responder ?? false ? Color.gris : Color.clear, radius: 5.0, x: self.isDigito4Responder ?? false ? 3.0 : 0, y: self.isDigito1Responder ?? false ? 3.0 : 0)
                            .border(Color.gris, width: self.isDigito4Responder ?? false ? 0 : 1)
                            .overlay(RoundedRectangle(cornerRadius: 3.0).stroke(Color.clear, lineWidth: 1))
                            .padding([.top,.bottom])
                            .padding([.leading, .trailing], 8)
                    }
                    .frame(height: 90)
                    .padding([.leading, .trailing])
                    
                    if tipoBiometria != .ninguna{
                        InfoBiometriaView(biometriaActiva: $biometriaActiva, tipoBiometria: tipoBiometria)
                            .padding()
                    }
                    
                    Button(action: {
                        if self.puedeContinuar(){
                            guardarPin(pin: "\(digito1Valor)\(digito2Valor)\(digito3Valor)\(digito4Valor)")
                            guardarTipoSeguridad(tipo: biometriaActiva ? .biometria : .pin)
                            goToPinConfigurado = true
                        }
                    }){EmptyView()}.buttonStyle(BotonPrincipal(text: "continuar".localized, enabled: self.puedeContinuar()))
                    .padding()
                    Spacer()
                    Group{
                        NavigationLink(destination: PinConfiguradoView(), isActive: $goToPinConfigurado){EmptyView()}
                    }
                },
            titulo: "PIN")
            .onAppear{
                self.viewModel.comprobarBiometria()
            }
            .onReceive(self.viewModel.$tipoBiometria){ value in
                if let tipo = value{
                    self.tipoBiometria = tipo
                }
            }
    }
    
    func puedeContinuar() -> Bool{
        let continuar = self.digito1Valor.count == 1 &&
                        self.digito2Valor.count == 1 &&
                        self.digito3Valor.count == 1 &&
                        self.digito4Valor.count == 1
        if continuar{
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            keyWindow?.endEditing(true)
        }
        return continuar
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        PinView()
    }
}
