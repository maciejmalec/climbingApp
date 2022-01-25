//
//  Route.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 25/01/2022.
//

import Foundation

struct Route: Codable, Hashable{
    var panel: Int
    var routeNo: Int
    var colour: String
    var start: StartOptions
    var grade: String
    var notes: String
    var setter: String
}
