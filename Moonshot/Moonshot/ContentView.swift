//
//  ContentView.swift
//  Moonshot
//
//  Created by Marlen Mynzhassar on 22.11.2020.
//

import SwiftUI

struct CrewMembersView: View {
    let mission: Mission
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(mission.astronauts, id:\.role) { crewMember in
                Text("\(crewMember.astronaut.name)")
            }
        }
    }
}

struct ContentView: View {
    let astronauts: [Astronaut] = Astronaut.allAustronauts
    let missions: [Mission] = Mission.allMissions
    
    @State private var isLaunchDateShown = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width:44, height:44)
                    
                    VStack(alignment:.leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if isLaunchDateShown {
                            Text(mission.formattedLaunchDate)
                        } else {
                            CrewMembersView(mission: mission)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(isLaunchDateShown ? "Crew members" : "Launch Date"){
                isLaunchDateShown.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
