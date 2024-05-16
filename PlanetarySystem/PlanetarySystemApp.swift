//
//  PlanetarySystemApp.swift
//  PlanetarySystem
//
//  Created by Davide Castaldi on 12/05/24.
//

import SwiftUI

@main
struct PlanetarySystemApp: App {
    
    @State var immersionMode: ImmersionStyle = .full
    var body: some Scene {
        //to dismiss the view, we declare an id so we can refer to this view
        WindowGroup(id: "main"){
            ContentView()
        }
        
        //same thing here
        ImmersiveSpace(id: "planets") {
            Planets()
        }
        
        ImmersiveSpace(id: "DIY") {
            PlanetsDIY()
        }
        
        ImmersiveSpace(id: "ImmersiveView") {
            ImmersiveView()
        }
        .immersionStyle(selection: $immersionMode, in: .full)
    }
}
