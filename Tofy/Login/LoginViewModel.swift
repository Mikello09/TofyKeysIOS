//
//  LoginViewModel.swift
//  Tofy
//
//  Created by usuario on 02/12/2020.
//

import Foundation
import Combine


class LoginViewModel: ObservableObject{
    
    var entrarCancelable: Cancellable?
    
    @Published var errorEntrar: TofyError?
    @Published var usuarioValidado: Usuario?
    @Published var tipoSeguridad: TipoSeguridad?
    
    
    func iniciarApp(){
        let usuario = getUsuario()
        if usuario.token != ""{
            self.tipoSeguridad = usuario.tipoSeguridad
        }
    }
    
    func entrarLlamada(email: String, contrasena: String) -> AnyPublisher<LoginRespuesta,Error>{
        return crearLlamada(url: loginUrl,
                            parametros: [
                                "email": email,
                                "contrasena": contrasena])
            .eraseToAnyPublisher()
    }
    
    func entrar(email: String, contrasena: String){
        entrarCancelable = entrarLlamada(email: email, contrasena: contrasena)
            .sink(receiveCompletion: {
                switch $0{
                case .failure(let error):
                    guard let errorValue = error as? TofyError else {
                        self.errorEntrar = TofyError(reason: "Error en parseo de error")
                        return
                    }
                    self.errorEntrar = errorValue
                case .finished:()
                }
            }, receiveValue: { respuesta in
                guardarUsuario(email: respuesta.usuario.email,
                               pass: respuesta.usuario.pass,
                               token: respuesta.usuario.token)
                self.usuarioValidado = respuesta.usuario
            })
    }
    
}

struct LoginRespuesta: Codable{
    var usuario: Usuario
}
