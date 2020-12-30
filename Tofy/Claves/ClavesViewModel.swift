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
    
}
