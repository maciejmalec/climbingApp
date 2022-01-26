//
//  RouteProgress.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 25/01/2022.
//

import Foundation

struct RouteProgress: Codable, Hashable{
    var routeNo: Int
    var completionNo: Int
    var notes: String
}
