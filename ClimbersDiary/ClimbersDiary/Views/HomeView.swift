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
    @State private var sortBtnTxt = "Sort by Grade ASC"
    @State private var routes = [Route]()
    @State private var displayRoutes = [Route]()
    @State private var progresses = [RouteProgress]()
    
    var body: some View {
        NavigationView{
                List {
                    ForEach(foundRoutes, id: \.self){ route in
                        NavigationLink(destination: RouteView(route: route)){
                            RouteListItem(route: route, progress: findProgress(route: route.routeNo))
                        }.padding().listRowBackground(getColor(color: route.colour))
                        
                    }
                }
                .navigationTitle("Routes")
                .searchable(text: $searchTxt)
                .toolbar {
                    HStack{
                        Button(action: {
                            routes.sort{
                                $0.routeNo < $1.routeNo
                            }}) {
                            Text("Reset")
                        }
                        Button(action: sort) {
                            Text(sortBtnTxt)
                        }
                    }

                }
        }.onAppear(perform: loadData)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func loadData(){
        fetchRoutes()
        fetchProgresses()
    }
    
    func fetchProgresses(){
        progresses.removeAll()
        if let data = dh.readLocalFile(name: "progresses") {
            for progress in dh.parseRouteProgress(data: data){
                progresses.append(progress)
            }
        }
    }
    
    func fetchRoutes() {
        routes.removeAll()
        if let data = dh.readLocalFile(name: "data") {
            for route in dh.parseRoute(data: data){
                routes.append(route)
            }
        }
    }
    
    var foundRoutes: [Route] {
        if searchTxt.isEmpty{
            return routes
        } else {
            return routes.filter { $0.grade.contains(searchTxt) }
        }
    }
    
    func findProgress(route: Int) -> Float {
        for progress in progresses{
            if(progress.routeNo == route){
                return Float(progress.completionNo)
            }
        }
        return 0
    }
    
    func sort(){
        if(sortBtnTxt == "Sort by Grade ASC"){
            sortBtnTxt = "Sort by Grade DSC"
            routes.sort{
                $0.grade < $1.grade
            }
        }else{
            sortBtnTxt = "Sort by Grade ASC"
            routes.sort{
                $0.grade > $1.grade
            }
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
            return Color(red: 255 / 255, green: 179 / 255, blue: 222 / 255)
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


