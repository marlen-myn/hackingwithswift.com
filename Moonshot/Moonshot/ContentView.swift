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
                    .accessibility(label: Text("Crew member \(crewMember.astronaut.name)"))
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
                            .accessibility(label: Text("Mission name \(mission.displayName))"))
                        if isLaunchDateShown {
                            Text(mission.formattedLaunchDate)
                                .accessibility(label: Text("Launch date \(mission.formattedLaunchDate))"))
                        } else {
                            CrewMembersView(mission: mission)
                        }
                    }
                }
                .accessibility(hint: Text("Click to get more details"))
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(isLaunchDateShown ? "Crew members" : "Launch Date") {
                isLaunchDateShown.toggle()
            }
            .accessibility(hint: Text("Toogle button to output information of either crew memebers or launch date in the table below"))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
