//
//  RotundaGatewayApp.swift
//  RotundaGateway
//
//  Created by Riana Santos on 4/28/25.
//

import SwiftUI

@main
struct RotundaGatewayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
