//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Marlen Mynzhassar on 28.11.2020.
//

import SwiftUI

struct CheckoutView: View {
    //@ObservedObject var order = Order()
    @ObservedObject var order = OrderClass()
    @State private var message = ""
    @State private var showingMessage = false
    @State private var messageTitle = ""
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is $\(order.item.cost, specifier: "%g")")
                        .font(.title)

                    Button("Place Order") {
                        placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingMessage) {
            Alert(title: Text(messageTitle), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.item) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                messageTitle = "Error"
                message = error?.localizedDescription ?? "Unknown error"
                showingMessage = true
                return
            }
                    
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                messageTitle = "Order Success!"
                message = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                showingMessage = true
            } else {
                print("Invalid response from server")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderClass())
    }
}
