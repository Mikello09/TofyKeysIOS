//
//  ClavesViewModel.swift
//  Tofy
//
//  Created by usuario on 29/12/20.
//

import Foundation
import Combine
import SwiftUI


class ClavesViewModel: ObservableObject{
    
    var cancelableEliminar: Cancellable?
    @Published var errorEliminandoClave: String?
    
    func sincronizarClavesLocales(claves: FetchedResults<Clave>){
        for clave in claves{
            if !clave.sincronizado{
                ClavesManager().sincronizarClave(clave: clave)
            }
        }
    }
    
    func getAllClaves(){
        ClavesManager().getAllClaves()
    }
    
    func eliminarClave(clave:Clave){
        cancelableEliminar = llamadaEliminarClave(clave: clave).sink(receiveCompletion: {
            switch $0{
            case .failure(_):
                self.errorEliminandoClave = "errorEliminarClave".localized
            case .finished:()
            }
        }, receiveValue: { response in
            ClavesManager().eliminarClaveLocal(clave: clave)
        })
    }
    
    func llamadaEliminarClave(clave: Clave) -> AnyPublisher<EliminarRespuesta, Error>{
        return crearLlamada(url: eliminarClaveUrl,
                            parametros: ["token":clave.token ?? "",
                                         "tokenUsuario":getUsuario().token])
            .eraseToAnyPublisher()
    }
    
    
    
}
