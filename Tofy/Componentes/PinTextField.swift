//
//  PinTextField.swift
//  Tofy
//
//  Created by usuario on 26/12/20.
//

import Foundation
import UIKit
import SwiftUI



struct PinTextField: UIViewRepresentable {

   class Coordinator: NSObject, UITextFieldDelegate {

      @Binding var text: String
      @Binding var valor: String
      @Binding var nextResponder : Bool?
      @Binding var isResponder : Bool?
    


     init(text: Binding<String>,valor: Binding<String>, nextResponder : Binding<Bool?> , isResponder : Binding<Bool?>) {
        _text = text
        _valor = valor
        _isResponder = isResponder
        _nextResponder = nextResponder
      }

      func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.valor = textField.text ?? ""
                self.text = textField.text ?? ""
                let timeShow = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: timeShow){
                    self.text = (textField.text ?? "") == "" ? "" : "*"
                }
                
                
            }
      }

      func textFieldDidBeginEditing(_ textField: UITextField) {
         DispatchQueue.main.async {
             self.isResponder = true
             self.nextResponder = false
         }
      }
    
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            if count == 1 {
                DispatchQueue.main.async {
                    self.isResponder = false
                    if self.nextResponder != nil {
                        self.nextResponder = true
                    }
                }
            }
            return count <= 1
      }
  }

  @Binding var text: String
  @Binding var valor: String
  @Binding var nextResponder : Bool?
  @Binding var isResponder : Bool?

  var isSecured : Bool = false
  var keyboard : UIKeyboardType

  func makeUIView(context: UIViewRepresentableContext<PinTextField>) -> UITextField {
      let textField = UITextField(frame: .zero)
      textField.isSecureTextEntry = isSecured
      textField.autocapitalizationType = .none
      textField.autocorrectionType = .no
      textField.keyboardType = keyboard
      textField.delegate = context.coordinator
      textField.textAlignment = .center
      textField.font = UIFont(name: "SourceSansPro-SemiBold", size: 20)
      textField.tintColor = .negro
      textField.textColor = .negro
      return textField
  }

  func makeCoordinator() -> PinTextField.Coordinator {
    return Coordinator(text: $text, valor: $valor, nextResponder: $nextResponder, isResponder: $isResponder)
  }

  func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<PinTextField>) {
       uiView.text = text
       if isResponder ?? false {
           uiView.becomeFirstResponder()
       }
  }

}
