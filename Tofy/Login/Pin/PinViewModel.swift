//
//  PinViewModel.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import Foundation
import Combine


class PinViewModel: ObservableObject{
    
    var cancellable: Cancellable?
    
    @Published var tipoBiometria: TipoBiometria?
    
    func comprobarBiometria(){
        cancellable = BiometriaHelper.getTipoBiometria()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { tipo in
                self.tipoBiometria = tipo
            })
    }
    
}
