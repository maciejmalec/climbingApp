//
//  HomeView.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 25/01/2022.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    private let dh = DataHandler()
    @State private var searchTxt = ""
    @State private var sortBtnTxt = "Sort by Grade ASC"
    @State private var routes = [Route]()
    @State private var displayRoutes = [Route]()
    @ObservedObject var model = ViewModel()
    
    init() {
        FirebaseApp.configure()
        model.getData()
    }
    
    var body: some View {
        NavigationView{
                List {
                    ForEach(foundRoutes, id: \.self){ route in
                        let progress = findProgress(route: route.routeNo)
                        
                        NavigationLink(destination: RouteView(route: route, progress: progress)){
                            RouteListItem(route: route, progress: Float(progress.completionNo))
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
    
    func findProgress(route: Int) -> RouteProgress {
        for progress in model.list{
            if(Int(progress.routeNo) == route){
                return progress
            }
        }
        return RouteProgress(id: "new", routeNo: -1, completionNo: 0, notes: "")
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


