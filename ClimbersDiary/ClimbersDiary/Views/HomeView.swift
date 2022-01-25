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
                            Text(route.grade)
                        }

                    }
                }.navigationTitle("Added Meals")
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


