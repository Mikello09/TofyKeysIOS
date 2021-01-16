//
//  SeguridadViewModel.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import Foundation
import Combine


class SeguridadViewModel: ObservableObject{
    
    @Published var tipoSeguridad: TipoSeguridad?
    @Published var tipoBiometria: TipoBiometria?
    var cancellable: Cancellable?
    
    
    func obtenerTipoSeguridad(){
        self.tipoSeguridad = getUsuario().tipoSeguridad
    }
    
    func obtenerTipoBiometria(){
        cancellable = BiometriaHelper.getTipoBiometria()
            .sink(receiveValue: { tipo in
                    self.tipoBiometria = tipo
            })
    }
    
}
