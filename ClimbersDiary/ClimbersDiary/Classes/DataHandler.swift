//
//  DataHandler.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 25/01/2022.
//

import Foundation

struct DataHandler{
    
    func readLocalFile(name: String) -> Data? {
        do{
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8){
                return jsonData
            }
        } catch{
            print(error)
        }
        return nil
    }
    
    func parseRoute(data: Data) -> [Route]{
        do{
            let routes = try JSONDecoder().decode([Route].self, from: data)
            return routes
        } catch{
            print(error)
        }
        return [Route]()
    }
    
}
