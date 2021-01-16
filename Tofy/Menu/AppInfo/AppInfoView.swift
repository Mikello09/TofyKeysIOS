//
//  AppInfoView.swift
//  Tofy
//
//  Created by usuario on 31/12/20.
//

import SwiftUI

struct AppInfoView: View {
    
    var body: some View {
        BaseView(showLoader: .constant(false),
                 content:
                    VStack{
                        Text("Tofy Keys")
                            .titulo(color: .principal)
                            .padding(.top, 64)
                        Image("tofy_icon")
                            .resizable()
                            .frame(width: 150, height: 150)
                        Text("Mikel López Salazar")
                            .titulo(color: .principal)
                            .padding(.top)
                        Text("mikelsalazarlopez@gmail.com")
                            .titulo(color: .principal)
                        Spacer()
                        Text("\("version".localized):\(getVersion())")
                            .padding()
                    }
                 , titulo: "App Info")
        
    }
    
    func getVersion() -> String{
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return ""
        }
        return version
    }
}

struct AppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoView()
    }
}
