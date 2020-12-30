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
    
    func obtenerTipoSeguridad(){
        self.tipoSeguridad = getUsuario().tipoSeguridad
    }
    
}
