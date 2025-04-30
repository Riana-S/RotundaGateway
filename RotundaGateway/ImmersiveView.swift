//
//  ImmersiveView.swift
//  RotundaGateway
//
//  Created by Riana Santos on 4/28/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

@MainActor
struct ImmersiveView: View {
    
    @State private var door = Entity()
    @State private var door1 = Entity()
    @State private var door2 = Entity()
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "RGScene", in: realityKitContentBundle) {
                content.add(scene)
                
                let skybox = await createSkyboxEntity(texture: "mirrored_hall_4k.hdr")
                content.add(skybox)
                
                guard let door = scene.findEntity(named: "Window") else{
                    fatalError()
                }
                self.door = door
                door.position = [0, 1, -2]
                door.scale *= [1, 2, 1]
                let world1 = Entity()
                world1.components.set(WorldComponent())
                let skybox1 = await createSkyboxEntity(texture: "misty_pines_4k.hdr")
                world1.addChild(skybox1)
                content.add(world1)
                let world1Portal = createPortal(target: world1)
                content.add(world1Portal)
                guard let anchorPortal1 = scene.findEntity(named: "AnchorPortal1") else{
                    fatalError("Cannot find portal anchor")
                }
                anchorPortal1.addChild(world1Portal)
                world1Portal.transform.rotation = simd_quatf(angle: .pi/2, axis: [1, 0, 0])
                
                guard let door1 = scene.findEntity(named: "Window_2") else{
                    fatalError()
                }
                self.door1 = door1
                door1.position = [-1.5, 1, -1]
                door1.scale *= [1, 2, 1]
                door1.transform.rotation = simd_quatf(angle: .pi/4, axis: [0, 1, 0])
                let world2 = Entity()
                world2.components.set(WorldComponent())
                let skybox2 = await createSkyboxEntity(texture: "shanghai_bund_4k.hdr")
                world2.addChild(skybox2)
                content.add(world2)
                let world2Portal = createPortal(target: world2)
                content.add(world2Portal)
                guard let anchorPortal2 = scene.findEntity(named: "AnchorPortal3") else{
                    fatalError("Cannot find portal anchor")
                }
                anchorPortal2.addChild(world2Portal)
                world2Portal.transform.rotation = simd_quatf(angle: .pi/2, axis: [1, 0, 0])
                
                guard let door2 = scene.findEntity(named: "Window_1") else{
                    fatalError()
                }
                self.door2 = door2
                door2.position = [1.5, 1, -1]
                door2.scale *= [1, 2, 1]
                door2.transform.rotation = simd_quatf(angle: -.pi/4, axis: [0, 1, 0])
                let world3 = Entity()
                world3.components.set(WorldComponent())
                let skybox3 = await createSkyboxEntity(texture: "klippad_sunrise_2_4k.hdr")
                world3.addChild(skybox3)
                content.add(world3)
                let world3Portal = createPortal(target: world3)
                content.add(world3Portal)
                guard let anchorPortal3 = scene.findEntity(named: "AnchorPortal2") else{
                    fatalError("Cannot find portal anchor")
                }
                anchorPortal3.addChild(world3Portal)
                world3Portal.transform.rotation = simd_quatf(angle: .pi/2, axis: [1, 0, 0])
            }
        }
    }
    func createSkyboxEntity(texture: String) async -> Entity {
        guard let resource = try? await TextureResource(named: texture) else {
            fatalError("Unable to load the skybox")
        }
        var material = UnlitMaterial()
        material.color = .init(texture: .init(resource))
        let entity = Entity()
        entity.components.set(ModelComponent(mesh: .generateSphere(radius: 1000), materials: [material]))
        entity.scale *= .init(x: -1, y: 1, z: 1)
        return entity
    }
    func createPortal(target: Entity) -> Entity {
        let portalMesh = MeshResource.generatePlane(width: 1, depth: 1)
        let portal = ModelEntity(mesh: portalMesh, materials: [PortalMaterial()])
        portal.components.set(PortalComponent(target: target))
        return portal
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
