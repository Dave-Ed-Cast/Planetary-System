//
//  PlanetsDIY.swift
//  PlanetarySystem
//
//  Created by Davide Castaldi on 13/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PlanetsDIY: View {
    
    //declare the environment to dismiss everything useless
    @Environment(\.dismissWindow) var dismissWindow
    
    //working with numbers is boring so let's define some references in the other file (Parameters)
    
    //this is an array initialized in a random way so that
    @State private var angles: [Float] = {
        var anglesArray: [Float] = []
        for _ in 0..<8 {
            let randomValue = Float.random(in: 1...10)
            anglesArray.append(.pi * randomValue)
        }
        return anglesArray
    }()
    
    @State private var activateRotation: Bool = false
    
    var body: some View {
        //create the reality view
        RealityView { content in
            
            //define the scene
            if let scene = try? await Entity(named: "Planets", in: realityKitContentBundle) {
                content.add(scene)
                
            }
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded({ value in
            let planet = findPlanet(scene: value.entity, name: value.entity.name)
            movePlanet(entity: planet!)
        }))
        .onAppear {
            //but before that let's get rid of everything else
            dismissWindow(id: "main")
        }
    }
    
    private func movePlanet(entity: Entity) {
        
        guard var parameters = orbitalParameters.first(where: { $0.planet == entity.name }) else {
            return
        }
        
        guard let index = orbitalParameters.firstIndex(where: { $0.planet == entity.name }) else {
            return
        }
        
        var angle = angles[index]
        
//        parameters.revolving.toggle()
        
        Timer.scheduledTimer(withTimeInterval: 0.001, repeats: parameters.revolving) { _ in
            let angularVelocity = 2 * .pi / parameters.period
            angle += 0.001 * Float(angularVelocity)
            
            let x = parameters.radius * cos(angle)
            let z = parameters.radius * sin(angle)
            
            let newPosition = SIMD3(x, entity.position.y, z)
            entity.position = newPosition
            
            angles[index] = angle
        }
        
    }
    
    
    private func findPlanet(scene: Entity, name: String) -> Entity? {
        var tempStack = [scene]
        
        while !tempStack.isEmpty {
            let current = tempStack.removeLast()
            if current.name == name {
                return current
            }
            
            tempStack.append(contentsOf: current.children)
        }
        
        return nil
    }
    
}

#Preview {
    PlanetsDIY()
}
