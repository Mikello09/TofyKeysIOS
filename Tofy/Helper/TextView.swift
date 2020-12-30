//
//  TextView.swift
//  Tofy
//
//  Created by usuario on 04/12/2020.
//

import Foundation
import SwiftUI


extension Text{
    
    func titulo(color: Color) -> Text{
        return self
            .font(.system(size: 21, weight: .semibold, design: .default))
            .foregroundColor(color)
    }
    
    func info() -> Text{
        return self
            .font(.system(size: 16))
            .foregroundColor(Color.negro)
    }
    
    func error() -> Text{
        return self
            .font(.system(size: 14))
            .foregroundColor(Color.rojo)
    }
    
    func boton() -> Text{
        return self
            .font(.system(size: 16, weight: .semibold, design: .default))
            .foregroundColor(Color.principal)
    }
    
}
