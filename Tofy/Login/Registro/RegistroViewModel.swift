//
//  RegistroViewModel.swift
//  Tofy
//
//  Created by usuario on 24/12/20.
//

import Foundation
import Combine
import SwiftUI


class RegistroViewModel: ObservableObject{
    
    @Published var error: String?
    @Published var registrado: Bool?
    
    var cancelable: Cancellable?
    
    func registrar(email: String, contrasena1: String, contrasena2: String){
        if contrasena1 != contrasena2{
            self.error = "Las contraseñas deben ser iguales"
        } else {
            cancelable = llamadaRegistro(email: email, contrasena: contrasena1).sink(receiveCompletion: {
                switch $0{
                case .failure(let err):
                    guard let error = err as? TofyError else {
                        self.error = "Error en el parseo del error"
                        return
                    }
                    self.error = error.reason
                case .finished: ()
                }
            }, receiveValue: { respuesta in
                guardarUsuario(email: respuesta.usuario.email,
                               pass: respuesta.usuario.pass,
                               token: respuesta.usuario.token)
                self.registrado = true
            })
        }
    }
    
    func llamadaRegistro(email: String, contrasena: String) -> AnyPublisher<RegistroRespuesta, Error>{
        return crearLlamada(url: registroUrl,
                            parametros:
                                ["email":email,
                                 "pass":contrasena])
            .eraseToAnyPublisher()
    }
    
}


struct RegistroRespuesta: Codable{
    var usuario: Usuario
}
