//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Marlen Mynzhassar on 07.12.2020.
//

import SwiftUI
import CodeScanner
import UserNotifications


struct ProspectsView: View {
    
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    @State private var isShowingScanner = false
    @State private var isShowingActionSheet = false
    @State private var sortedBy: ProspectSorting = .name
    
    
    enum ProspectSorting {
        case name, mostRecent
    }
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: prospect.isConnected ?  "checkmark.circle" : "questionmark.diamond")
                            VStack(alignment: .leading) {
                                Text(prospect.name)
                                    .font(.headline)
                                Text(prospect.emailAddress)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .contextMenu {
                        Button(prospect.isConnected ? "Mark Uncontacted" : "Mark Contacted") {
                            prospects.toogle(prospect)
                        }
                        if !prospect.isConnected {
                            Button("Remind Me") {
                                addNotification(for: prospect)
                            }
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    prospects.delete(at: indexSet)
                })
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button("Sort") {
                isShowingActionSheet = true
            }, trailing: Button(action: {
                isShowingScanner = true
            }){
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Abil Mynzhassar\nmarlen.myn@gmail.com", completion: handleScan)
            }
            .actionSheet(isPresented: $isShowingActionSheet) {
                ActionSheet(title: Text("Choose how would you like to sort your data"),
                            buttons: [
                                .default(Text("Name")) {
                                    sortedBy = .name
                                },
                                .default(Text("Most Recent")) {
                                    sortedBy = .mostRecent
                                },
                                .cancel()
                            ]
                )
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func sortBy(p1: Prospect, p2: Prospect) -> Bool {
        switch sortedBy {
            case .name:
                return p1.name < p2.name
            case .mostRecent:
                return p1.addedTime > p2.addedTime
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
            case .none:
                return prospects.people.sorted(by: sortBy)
            case .contacted:
                return prospects.people.filter( { $0.isConnected } ).sorted(by: sortBy)
            case .uncontacted:
                return prospects.people.filter( { !$0.isConnected } ).sorted(by: sortBy)
        }
    }
    
    var title: String {
        switch filter {
            case .none:
                return "Everyone"
            case .contacted:
                return "Contacted people"
            case .uncontacted:
                return "Uncontacted people"
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center  = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                print("D'oh")
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
