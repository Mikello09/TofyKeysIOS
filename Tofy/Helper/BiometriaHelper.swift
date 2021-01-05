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
    
    func activarMensaje() -> String{
        switch self {
        case .ninguna:
            return ""
        case .touchID:
            return "activarTouchID".localized
        case .faceID:
            return "activarFaceID".localized
        }
    }
    
    func icono() -> String{
        switch self {
        case .ninguna:
            return ""
        case .touchID:
            return "huella_icon"
        case .faceID:
            return "face_icono"
        }
    }
    
    func titulo() -> String{
        switch self {
        case .ninguna:
            return ""
        case .touchID:
            return "Touch ID"
        case .faceID:
            return "Face ID"
        }
    }
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
    
    static func pedirBiometria(biometriaCorrecta: @escaping () -> ()){
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return
        }
        
        var reason = ""
        switch(context.biometryType){
        case .faceID:
            reason = "bio_cara_acceder".localized
        case .touchID:
            reason = "bio_huella_acceder".localized
        case .none:
            break
        @unknown default:
            break
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { isAuthorized, error in
            if isAuthorized{
                biometriaCorrecta()
            }
        }
        
        
    }
}


