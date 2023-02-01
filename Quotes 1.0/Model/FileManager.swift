//
//  FileManager.swift
//  Quotes 1.0
//
//  Created by Виталий Татун on 16.01.23.
//

import Foundation


extension FileManager {
    
    private static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private static var archiveURL = documentsDirectory.appendingPathComponent("myQuotes").appendingPathExtension("plist")
    
//    static func sampleQuotes() -> [Quote] {
//        return sampleQuotes()
//    }
    
    static func saveToFile(quotes: [Quote]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedQuotes = try? propertyListEncoder.encode(quotes)
        try? encodedQuotes?.write(to: archiveURL, options: .noFileProtection)
        print("Saved")
    }
    
    static func loadFromFile() -> [Quote]? {
        guard let retrievedQuoteData = try? Data(contentsOf: archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        print("Loaded")
        return try? propertyListDecoder.decode(Array<Quote>.self, from: retrievedQuoteData)
    }
    
}
