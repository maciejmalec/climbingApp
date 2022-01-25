//
//  HomeView.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 25/01/2022.
//

import SwiftUI

struct HomeView: View {
    
    private let dh = DataHandler()
    @State private var searchTxt = ""
    @State private var routes = [Route]()
    
    var body: some View {
        NavigationView{
                List {
                    ForEach(routes, id: \.self){ route in
                        NavigationLink(destination: RouteView(route: route)){
                            VStack{
                                Text("Route number: " + String(route.routeNo))
                                    
                                    
                                Text("Grade: " + route.grade)
                                ProgressView("Progress…", value: 1, total: 3)
                                    .accentColor(.green)
                            }
                            
                        }.listRowBackground(getColor(color: route.colour))
                        

                    }
                }.navigationTitle("Routes")
                .searchable(text: $searchTxt)
        }.onAppear(perform: fetch)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func fetch() {
        routes.removeAll()
        if let data = dh.readLocalFile(name: "data") {
            for route in dh.parseRoute(data: data){
                routes.append(route)
            }
        }
    }
    
    var foundRoutes: [Route] {
        if searchTxt.count < 3 {
            return [Route]()
        } else {
            return routes.filter{ $0.colour.contains(searchTxt)}
        }
    }
    
    func getColor(color: String) -> Color {
        
        switch color{
        case "Orange":
            return Color.orange
        case "Green":
            return Color.green
        case "Blue":
            return Color.blue
        case "Purple":
            return Color.purple
        case "Black":
            return Color.gray
        case "Pink":
            return Color.pink
        case "Red":
            return Color.red
        case "Yellow":
            return Color.yellow
        case "Mint":
            return Color.mint
        case "Wood":
            return Color.brown
        default:
            return Color.white
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


