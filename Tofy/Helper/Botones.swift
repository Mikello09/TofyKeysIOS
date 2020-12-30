//
//  Botones.swift
//  Tofy
//
//  Created by usuario on 21/12/20.
//

import Foundation
import SwiftUI


let BUTTON_HEIGHT: CGFloat = 48

struct BotonPrincipal: ButtonStyle {
    
    var text = ""
    var enabled = true
    var color : UIColor = .white
    

    init(text: String, enabled : Bool) {
        
        self.text = text
        self.enabled = enabled
        
        if enabled {
            self.color = UIColor.principal
        }else {
            self.color = UIColor.gris
        }
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            Rectangle()
                .cornerRadius(CGFloat(3.0))
                .foregroundColor(Color.init(self.color))
            
            Text(text)
                .foregroundColor(.blanco)
                .font(.system(size: 18, weight: .bold, design: .default))
        }.frame(height: BUTTON_HEIGHT)
    }
}

struct BotonCambiante: ButtonStyle{

    var texto: String
    @Binding var seleccionado: Bool

    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            if seleccionado{
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.principal, lineWidth: 1)
                    .foregroundColor(.blanco)
            } else {
                Rectangle()
                    .cornerRadius(3)
                    .shadow(radius: 3)
                    .foregroundColor(.blanco)
            }
            Text(texto)
                .foregroundColor(.negro)
                .font(.custom("SourceSansPro-SemiBold", size: 18.0))
                .multilineTextAlignment(.center)
        }
        .frame(height: BUTTON_HEIGHT*2)
    }
}

struct BotonCircular: ButtonStyle{

    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .center){
            Circle()
                .fill(Color.principal)
                .frame(width: 100, height: 100)
            Image("add_icon_blanco")
                .resizable()
                .frame(width: 40, height: 40)
        }
        .frame(height: BUTTON_HEIGHT*2)
    }
}

struct BotonConColor: ButtonStyle {
    
    var color: Color
    var texto: String
    
    init(color: Color, texto: String){
        self.color = color
        self.texto = texto
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            Rectangle()
                .cornerRadius(3)
                .shadow(radius: 3)
                .foregroundColor(color)
            Text(texto)
                .titulo(color: .blanco)
        }
        .frame(height: BUTTON_HEIGHT)
    }
    
}
