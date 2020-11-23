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
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geometry.size.width)
                
                Text(astronaut.description)
                    .padding()
                
                Text("All missions:")
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                    ForEach(missions) { mission in
                        if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:44, height:44)
                                
                                VStack(alignment:.leading) {
                                    Text(mission.displayName)
                                        .font(.headline)
                                    Text(mission.formattedLaunchDate)
                                }
                            }
                            .frame(maxWidth:.infinity)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts:[Astronaut] = Astronaut.allAustronauts
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
