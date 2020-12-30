//
//  Usuario.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import Foundation

enum TipoSeguridad: String, Codable{
    case ninguna = "Ninguna"
    case pin = "Pin"
    case biometria = "Biometria"
    
    func mensaje() -> String{
        switch self{
        case .ninguna:
            return "seguridadNingunaMensaje".localized
        case .pin:
            return "seguridadPinMensaje".localized
        case .biometria:
            return "seguridadBiometriaMensaje".localized
        }
    }
    
    func imagen() -> String{
        switch self{
        case .ninguna:
            return ""
        case .pin:
            return "pin_icon"
        case .biometria:
            return "huella_icon"
        }
    }
}

struct Usuario: Codable{
    var email: String
    var pass: String
    var token: String
    var tipoSeguridad: TipoSeguridad?
    var pin: String?
}

func guardarUsuario(email: String, pass: String, token: String){
    UserDefaults.standard.setValue(email, forKey: "email")
    UserDefaults.standard.setValue(pass, forKey: "pass")
    UserDefaults.standard.setValue(token, forKey: "token")
}

func guardarTipoSeguridad(tipo: TipoSeguridad){
    UserDefaults.standard.setValue(tipo.rawValue, forKey: "tipoSeguridad")
}

func guardarPin(pin: String){
    UserDefaults.standard.setValue(pin, forKey: "pin")
}

func getUsuario() -> Usuario{
    return Usuario(email: UserDefaults.standard.string(forKey: "email") ?? "",
                   pass: UserDefaults.standard.string(forKey: "pass") ?? "",
                   token: UserDefaults.standard.string(forKey: "token") ?? "",
                   tipoSeguridad: TipoSeguridad(rawValue: UserDefaults.standard.string(forKey: "tipoSeguridad") ?? "Ninguna") ?? .ninguna,
                   pin: UserDefaults.standard.string(forKey: "pin"))
}

func eliminarUsuario(){
    UserDefaults.standard.setValue("", forKey: "email")
    UserDefaults.standard.setValue("", forKey: "pass")
    UserDefaults.standard.setValue("", forKey: "token")
    UserDefaults.standard.setValue("", forKey: "tipoSeguridad")
    UserDefaults.standard.setValue("", forKey: "pin")
}
