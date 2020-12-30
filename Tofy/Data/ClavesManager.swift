//
//  Clave.swift
//  Tofy
//
//  Created by usuario on 29/12/20.
//

import Foundation
import CoreData
import Combine
import UIKit

class ClavesManager{
    
    var cancellableGuardar: Cancellable?
    var cancellableGetAllClaves: Cancellable?
    var cancellableEliminar: Cancellable?

    func guardarClave(token: String,
                      tokenUsuario: String,
                      titulo: String,
                      valor: String,
                      usuario: String,
                      contrasena: String,
                      fecha: String,
                      sincronizado: Bool = false){
        let newClave = Clave(context: PersistenceController.shared.container.viewContext)
        newClave.token = token
        newClave.tokenUsuario = tokenUsuario
        newClave.titulo = titulo
        newClave.valor = valor
        newClave.usuario = usuario
        newClave.contrasena = contrasena
        newClave.fecha = fecha
        newClave.sincronizado = sincronizado
        guardarClaveEnPersistencia()
        sincronizarClave(clave: newClave)
    }
    
    func actualizarValor(clave: Clave, titulo: String, valor: String){
        clave.titulo = titulo
        clave.valor = valor
        clave.sincronizado = false
        guardarClaveEnPersistencia()
        //sincronizarClave(clave: clave)
        eliminarClaveDeServidor(clave: clave)
    }
    
    func actualizarUsuarioContrasena(clave: Clave, titulo: String, usuario: String, contrasena: String){
        clave.titulo = titulo
        clave.usuario = usuario
        clave.contrasena = contrasena
        clave.sincronizado = false
        guardarClaveEnPersistencia()
        sincronizarClave(clave: clave)
    }
    
    func eliminarClave(clave: Clave){
        PersistenceController.shared.container.viewContext.delete(clave)
        guardarClaveEnPersistencia()
        eliminarClaveDeServidor(clave: clave)
    }
    
    func guardarClaveEnPersistencia(){
        let context = PersistenceController.shared.container.viewContext
        do{
            try context.save()
        }catch{
            print("Error updating usuario/contrasena in CoreData")
            return
        }
    }
    
    func eliminarClaveDeServidor(clave: Clave){
        cancellableEliminar = llamadaEliminarClave(clave: clave).sink(receiveCompletion: {
            switch $0{
            case .failure(let err):
                print("")
            case .finished:()
            }
        }, receiveValue: { response in
            print("")
        })
    }
    
    func sincronizarClave(clave: Clave){
        cancellableGuardar = llamadaGuardarClave(clave: clave).sink(receiveCompletion: {
            switch $0{
            case .failure(let err):()
            case .finished:()
            }
        }, receiveValue: { response in
            clave.sincronizado = true
            self.guardarClaveEnPersistencia()
        })
    }
    
    func getAllClaves(){
        cancellableGetAllClaves = llamadaGetAllClaves().sink(receiveCompletion: {
            switch $0{
            case .failure(let err):()
            case .finished:()
            }
        }, receiveValue: { response in
            for clave in response.claves{
                self.guardarClave(token: clave.token,
                             tokenUsuario: clave.tokenUsuario,
                             titulo: clave.titulo,
                             valor: clave.valor,
                             usuario: clave.usuario,
                             contrasena: clave.contrasena,
                             fecha: clave.fecha,
                             sincronizado: true)
            }
        })
    }
    
    func llamadaGuardarClave(clave: Clave) -> AnyPublisher<GuardarClaveResponse,Error>{
        return crearLlamada(url: guardarClaveUrl,
                            parametros: [
                                "usuarioToken": getUsuario().token,
                                "token": clave.token ?? "",
                                "titulo":clave.titulo ?? "",
                                "valor":clave.valor ?? "",
                                "usuario":clave.usuario ?? "",
                                "contrasena":clave.contrasena ?? "",
                                "fecha":clave.fecha ?? ""])
            .eraseToAnyPublisher()
    }
    
    func llamadaGetAllClaves() -> AnyPublisher<GetAllClavesResponse, Error>{
        return crearLlamada(url: getAllClavesUrl,
                            parametros: ["token":getUsuario().token])
            .eraseToAnyPublisher()
    }
    
    func llamadaEliminarClave(clave: Clave) -> AnyPublisher<String, Error>{
        return crearLlamada(url: eliminarClaveUrl,
                            parametros: ["token":clave.token ?? ""])
            .eraseToAnyPublisher()
    }
    
    func generarToken() -> String{
        let number = Int.random(in: 0..<100000)
        return "\(number)"
    }
}

struct GuardarClaveResponse: Codable{
    var clave: ClaveModel
}

struct GetAllClavesResponse: Codable{
    var claves: [ClaveModel]
}

struct ClaveModel: Codable{
    var tokenUsuario: String
    var token: String
    var titulo: String
    var valor: String
    var usuario: String
    var contrasena: String
    var fecha: String
}




