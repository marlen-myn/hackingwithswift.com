//
//  AstronautView.swift
//  Moonshot
//
//  Created by Marlen Mynzhassar on 22.11.2020.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission] = Mission.allMissions
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width)
                        .accessibility(removeTraits: .isImage)
                        .accessibility(label: Text("Image of: \(astronaut.name)"))
                    
                    Text(astronaut.description)
                        .accessibility(label: Text("Information about astronaut: \(astronaut.description)"))
                        .padding()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("All missions:")
                                .accessibility(label: Text("All missions of astronauts"))
                                .padding(.bottom)
                            
                            ForEach(missions) { mission in
                                if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                                    HStack(alignment: .lastTextBaseline) {
                                        Image(mission.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:44, height:44)
                                            .accessibility(label: Text("Logo of mission: \(mission.image)"))
                                        
                                        VStack(alignment:.leading) {
                                            Text(mission.displayName)
                                                .font(.headline)
                                                .accessibility(label: Text("Mission name: \(mission.displayName)"))
                                            
                                            Text(mission.formattedLaunchDate)
                                                .accessibility(label: Text("Mission launchdate: \(mission.formattedLaunchDate)"))
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    Spacer(minLength:25)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts:[Astronaut] = Astronaut.allAustronauts
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[7])
    }
}
