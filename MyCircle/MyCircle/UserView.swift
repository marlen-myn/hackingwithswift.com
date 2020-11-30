//
//  UserView.swift
//  FriendsCircle
//
//  Created by Marlen Mynzhassar on 30.11.2020.
//

import SwiftUI

struct UserView: View {
    @Environment(\.managedObjectContext) private var moc
    let user: CDUser
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Age: \(user.age)")
                Text("\(user.company) (\(user.email))")
                Text("\(user.address)")
                Text("Registered at: \(user.friendlyDateRegistered)")
                    .font(.footnote)
                    .padding(.bottom)
                
                Divider()
                
                Text("\(user.about)")
                
                Text("Interests:")
                    .font(.headline)
                    .padding(.top)
                
                Text(user.friendlyUserTags)
                    .foregroundColor(.green)
                
                Group {
                    Text("Friends(\(user.friends.count)):")
                        .font(.headline)
                        .padding(.top)
                    
                    ForEach(user.friendsArray, id:\.self) { friend in
                        NavigationLink(destination: UserView(user: friend.userDetails)) {
                            HStack {
                                Image(systemName: "person.crop.circle.badge.checkmark")
                                VStack {
                                    Text("\(friend.name), \(friend.userDetails.age)")
                                        .padding(2)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle(user.name)
        }
    }
}
