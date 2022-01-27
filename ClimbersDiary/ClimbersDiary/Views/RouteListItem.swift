//
//  RouteListItem.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 26/01/2022.
//

import SwiftUI

struct RouteListItem: View {
    
    @State var route: Route
    @State var progress: Float
    private let progressBarColours = [Color.white, Color.red, Color.yellow, Color(red: 57 / 255, green: 255 / 255, blue: 20 / 255)]
    
    var body: some View {
        VStack{
            Text("Route number: " + String(route.routeNo))
            Text("Grade: " + route.grade)
        
            ProgressView( value: progress, total: 3)
                .frame(height: 10.0)
                .accentColor(progressBarColours[Int(progress)])
                .background(Color.black)
                .cornerRadius(15)
                
        }
        .cornerRadius(15)
    }
}

