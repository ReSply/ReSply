//
//  Product.swift
//  ReSply
//
//  Created by Zeno Koller on 11.10.14.
//  Copyright (c) 2014 Zeno Koller. All rights reserved.
//

import Foundation

class Product {

    var EAN: String!
    var id: String! // The id we received from the API
    var name: String!
    var mainCategory: String!
    var catPath: [String]!
    var addedDate: NSDate!
    var tickedOff: Bool!
    
    // Init Product from JSON
    init(data: JSON, ean: String) {
        self.EAN = ean
        self.addedDate = NSDate()
        self.tickedOff = false
        
        self.catPath = []
        for (index: String, subJson: JSON) in data["catPath"] {
            self.catPath.append(subJson["name"].string!)
        }
        
        if let name = data["name"].string {
            // There's a name property
            self.name = name;
        } else {
            // No name, take it from catPath
            let catPathDepth = catPath.count - 1
            if catPathDepth > 3 { // Deep catPath. Take last 2 categories
                self.name = "\(catPath[catPathDepth - 1]),  \(catPath[catPathDepth])"
            } else { // Shallow catpath. Take most specific
                self.name = catPath[catPathDepth]
            }
        }
        
        if let cat = self.catPath[2] as String? {
            self.mainCategory = cat
        } else {
            self.mainCategory = "Nicht kategorisiert"
        }
        
        println("Created product with name \(name)")
    }
    
    func toggleTickedOff() {
        self.tickedOff = !self.tickedOff        
    }
    
}