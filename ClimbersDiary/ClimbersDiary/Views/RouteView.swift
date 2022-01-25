//
//  RouteView.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 25/01/2022.
//

import SwiftUI

struct RouteView: View {
    
    @State var route: Route
    
    var body: some View {
        Text(route.colour)
    }
}

