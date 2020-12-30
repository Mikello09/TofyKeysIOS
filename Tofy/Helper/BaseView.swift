//
//  BaseView.swift
//  Tofy
//
//  Created by usuario on 26/12/20.
//

import SwiftUI

struct BaseView<Content>: View where Content: View{
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var showLoader: Bool
    
    var content: Content
    var titulo: String?
    
    var body: some View {
        ZStack{
            if titulo != nil{
                content
                    .navigationBarColor(.principal, titulo ?? "", goBack)
            } else {
                content
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
                    .navigationBarBackButtonHidden(true)
            }
            if showLoader{
                VStack{
                    Spacer()
                    LottieView(name: "loading", play: .constant(1), loopFinished: nil)
                        .frame(width: 300, height: 300)
                        .padding()
                    Spacer()
                }
                
            }
        }
    }
    
    func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
}
