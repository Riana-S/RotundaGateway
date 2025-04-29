//
//  ImmersiveView.swift
//  RotundaGateway
//
//  Created by Riana Santos on 4/28/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    @State private var door = Entity()
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "RGScene", in: realityKitContentBundle) {
                content.add(scene)
                
                guard let door = scene.findEntity(named: "Window") else{
                    fatalError()
                }
                self.door = door
                door.position = [0, 1, -2]
                door.scale *= [1, 2, 1]
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
