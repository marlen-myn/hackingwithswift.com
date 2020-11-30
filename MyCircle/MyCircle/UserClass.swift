//
//  UserClass.swift
//  
//
//  Created by Marlen Mynzhassar on 30.11.2020.
//

import CoreData
import Foundation

class UserClass: ObservableObject {
    
    static func updateDataFromServer() -> [User] {
        var fetchedItems = [User]()
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return []
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-SS:S'Z'"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                if let decodedResponse = try? decoder.decode([User].self, from: data) {
                    fetchedItems = decodedResponse
                    semaphore.signal()
                    return
                }
                
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
        
        semaphore.wait()
        return fetchedItems
    }
    
    /* Delete this function later */
    static func deleteAllData(in context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDUser")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    
    static func synchronizeData(in context: NSManagedObjectContext) {
        let items = UserClass.updateDataFromServer()
        
        do {
            let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
            let fetchedItemsArray = try context.fetch(fetchRequest)
            
            for item in items {
                if fetchedItemsArray.firstIndex(where: { $0.id == item.id }) == nil  {
                    let newUser = CDUser(context: context)
                    newUser.id = item.id
                    newUser.name = item.name
                    newUser.isActive = item.isActive
                    newUser.age = Int16(item.age)
                    newUser.company = item.company
                    newUser.email = item.email
                    newUser.address = item.address
                    newUser.about = item.about
                    newUser.registered = item.registered
                    
                    for tag in item.tags {
                        let newTag = CDTag(context: context)
                        newTag.name = tag
                        newTag.user = newUser
                    }
             
                    for friend in item.friends {
                        let newFriend = CDFriend(context: context)
                        newFriend.id = friend.id
                        newFriend.name = friend.name
                        newFriend.user = newUser
                    }
                    
                    if context.hasChanges {
                        try? context.save()
                    }
                }
            }
            
        } catch let error as NSError {
            print("Error getting User: \(error.localizedDescription), \(error.userInfo)")
        }
    }
}
