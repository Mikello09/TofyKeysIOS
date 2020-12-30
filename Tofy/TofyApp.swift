//
//  TofyApp.swift
//  Tofy
//
//  Created by usuario on 02/12/2020.
//

import SwiftUI

@main
struct TofyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
