//
//  ContentView.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 25/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 1
    
    var body: some View {
            
        TabView(selection: $selection) {
            CircuitView().tabItem {
                Image(systemName: "map.fill")
                Text("Circuit")
            }.tag(0)
            HomeView().tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }.tag(1)
            FriendsView().tabItem{
                Image(systemName: "person.2.fill")
                Text("Friends")
            }.tag(2)
        }
        .accentColor(.brown)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
