//
//  StartOptions.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 25/01/2022.
//

import Foundation

enum StartOptions: String, Codable {
    case ST
    case HS
    case SS

    var description : String {
      switch self {
      // Use Internationalization, as appropriate.
      case .ST: return "Standing Start"
      case .HS: return "Hagnging Start"
      case .SS: return "Sitting Start"
      }
    }
}
