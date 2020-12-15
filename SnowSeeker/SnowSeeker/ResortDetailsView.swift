//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Marlen Mynzhassar on 15.12.2020.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            Text("Size: \(resort.friendlySize)").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(resort.friendlyPrice)").layoutPriority(1)
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
