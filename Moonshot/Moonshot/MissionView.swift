//
//  MissionView.swift
//  Moonshot
//
//  Created by Marlen Mynzhassar on 22.11.2020.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    func logoWidth(_ geo: GeometryProxy) -> CGFloat? {
        return geo.frame(in: .global).maxY * 0.65 > geo.frame(in: .local).midX * 0.8 ? geo.frame(in: .global).maxY * 0.65 : geo.frame(in: .global).midX * 0.8
    }
    
    var body: some View {
        GeometryReader { fullsize in
            
            ScrollView(.vertical) {
                
                GeometryReader { geo in
                    HStack {
                        Spacer()
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: logoWidth(geo), height: fullsize.size.height * 0.3)
                            .padding()
                            .accessibility(hint: Text("Logo of mission illustrated"))
                            .animation(.default)
                        Spacer()
                    }
                }
                .frame(height: fullsize.size.height * 0.3)
                .padding()
                
                Text("Launch date: \(mission.formattedLaunchDate)")
                
                
                Text(mission.description)
                    .padding()
                    .accessibility(label: Text("Mission description: \(mission.description)"))
                
                
                ForEach(astronauts, id:\.role) { crewMember in
                    NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width:90, height:60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1))
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .accessibility(label: Text("Crew member: \(crewMember.astronaut.name)"))
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .accessibility(label: Text("Role: \(crewMember.role)"))
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .accessibility(hint: Text("Click to get more details about a crew member "))
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer(minLength:25)
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        self.astronauts = mission.astronauts
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions:[Mission] = Mission.allMissions
    static let astronauts:[Astronaut] = Astronaut.allAustronauts
    
    static var previews: some View {
        MissionView(mission: missions[9], astronauts: astronauts)
    }
}
