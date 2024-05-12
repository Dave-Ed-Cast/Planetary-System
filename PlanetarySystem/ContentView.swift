//
//  ContentView.swift
//  PlanetarySystem
//
//  Created by Davide Castaldi on 12/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

//first things first, we declare the container of the immersive space
struct ContentView: View {
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    var body: some View {
        
        VStack {
            Button {
                Task {
                    //this is an async call (call when ready)
                    await openImmersiveSpace(id: "saturn")
                }
            } label: {
                Text("Open planetary system")
            }
        }
        .padding()
        .navigationTitle("Content")
        
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
