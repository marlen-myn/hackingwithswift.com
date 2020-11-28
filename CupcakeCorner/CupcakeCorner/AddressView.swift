//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Marlen Mynzhassar on 28.11.2020.
//

import SwiftUI

struct AddressView: View {
    //@ObservedObject var order = OrderClass()@ObservedObject var order = Order()
    @ObservedObject var order = OrderClass()
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.item.name)
                TextField("Street Address", text: $order.item.streetAddress)
                TextField("City", text: $order.item.city)
                TextField("Zip", text: $order.item.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.item.hasValidAddress == false)
            
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderClass())
    }
}
