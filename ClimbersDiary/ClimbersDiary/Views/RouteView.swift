//
//  RouteView.swift
//  ClimbersDiary
//
//  Created by Maciej Malec on 25/01/2022.
//

import SwiftUI

struct RouteView: View {
    
    @State var route: Route
    @State var progress: RouteProgress
    
    var body: some View {
        VStack{
            Text("Route number: " + String(route.routeNo))
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Divider()
            HStack{
                VStack{
                    Text("Grade:")
                    Text("Panel:")
                    Text("Start position:")
                    Text("Colour:")
                    Text("Setter:")
                }
                .padding(.top)
                VStack{
                    Text(route.grade)
                    Text(String(route.panel))
                    Text(route.start.description)
                    Text(route.colour)
                    Text(route.setter)
                }
                .padding(.top)
            }
            VStack{
                Text("Notes")
                    .padding(.top)
                Text(route.notes)
                
            }
            Divider()
            VStack{
                Text("Personal Progress")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Times completed: " + String(progress.completionNo))
                    .padding(.vertical)
                HStack{
                    Spacer()
                    Button(action: {
                        if progress.completionNo > 0 {
                            progress.completionNo -= 1
                        }
                    }) {
                        Text("-")
                            .frame(width: 50.0, height: 50.0)
                            .font(.system(size: 40))
                    }
                    Spacer()
                    Button(action: {
                        if progress.completionNo < 3 {
                            progress.completionNo += 1
                        }
                    }) {
                        Text("+")
                            .frame(width: 50.0, height: 50.0)
                            .font(.system(size: 40))
                    }
                    Spacer()
                }
                Text("Notes")
                    .padding(.top)
                TextEditor(text: .constant(progress.notes))
                    .padding(.horizontal)
            }
            Button(action: saveProgress) {
                Text("Save changes")
            }
            Spacer()
        }
    }
    
    func saveProgress(){
        //save new record
        if progress.id == "new" {
            progress.routeNo = route.routeNo
            ViewModel().addProgress(progress: progress)
        }else{
            ViewModel().udpateProgress(progress: progress)
        }
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView(route: Route(panel: 3, routeNo: 2, colour: "Orange", start: StartOptions.HS, grade: "4+", notes: "notes", setter: "qweqwe"), progress: RouteProgress(id: "new", routeNo: 4, completionNo: 2, notes: "es"))
    }
}


