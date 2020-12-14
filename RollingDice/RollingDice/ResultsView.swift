//
//  ResultsView.swift
//  RollingDice
//
//  Created by Marlen Mynzhassar on 14.12.2020.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Roll.date, ascending: false)
    ]) var results: FetchedResults<Roll>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(results) { result in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total: \(result.total)")
                            Text("\(result.friendlyDate)")
                                .font(.footnote)
                        }
                        Spacer()
                        Text("dices: \(result.rollquantity) / sides: \(result.sides)")
                    }
                }
            }
            .navigationBarTitle("Results(\(results.count))", displayMode: .inline)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
