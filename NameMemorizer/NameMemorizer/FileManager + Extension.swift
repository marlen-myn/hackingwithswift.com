//
//  FileManager + Extension.swift
//  NameMemorizer
//
//  Created by Marlen Mynzhassar on 05.12.2020.
//

import UIKit

extension FileManager {

    static func saveData(_ data: Data, filename: String) throws {
        try data.write(to: getDocumentsDirectory().appendingPathComponent(filename), options: [.atomicWrite, .completeFileProtection])
    }
    
    static func getDataURL(filename: String) -> URL {
        getDocumentsDirectory().appendingPathComponent(filename)
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
