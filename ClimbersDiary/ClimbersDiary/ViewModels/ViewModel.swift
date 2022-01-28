//
//  ViewModel.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 28/01/2022.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    
    @Published var list = [RouteProgress]()
    
    func getData() {
        
        //Get a reference to db
        let db = Firestore.firestore()
        
        //Read docuemnts at specific path
        db.collection("progresses").getDocuments { snapshot, error in
            
            if error == nil{
                if let snapshot = snapshot {
                    //do in main thread as affects UI
                    DispatchQueue.main.async {
                        
                        for d in snapshot.documents {
                            let temp = RouteProgress(routeNo: d.documentID,
                                                     completionNo: d["completionNo"] as? Int ?? 0,
                                                     notes: d["notes"] as? String ?? "")
                            self.list.append(temp)
                        }
                        
                    }
                    
                }
            }else{
                print("error")
            }
            
        }

        
    }
}
