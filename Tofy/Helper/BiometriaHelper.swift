//
//  BiometriaHelper.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import Foundation
import LocalAuthentication
import Combine



enum TipoBiometria: String{
    case ninguna = "ninguna"
    case touchID = "touchID"
    case faceID = "faceID"
}

class BiometriaHelper{
    static func getTipoBiometria() -> AnyPublisher<TipoBiometria,Never>{
        
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return Just(.ninguna).eraseToAnyPublisher()
        }
        switch context.biometryType{
            case .faceID:
                return Just(.faceID).eraseToAnyPublisher()
            case .none:
                return Just(.ninguna).eraseToAnyPublisher()
            case .touchID:
                return Just(.touchID).eraseToAnyPublisher()
            @unknown default:
                return Just(.ninguna).eraseToAnyPublisher()
        }
    }
}


