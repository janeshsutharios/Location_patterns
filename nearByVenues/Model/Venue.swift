//
//  Venue.swift
//  nearByVenues
//
//  Created by Jitendra Gaur on 3/17/17.
//  Copyright © 2017 Jitendra Gaur. All rights reserved.
//

import Foundation

struct Venue {
    var id, name: String
    var location: Location
    
    init(jsonData: [String: Any]) {
        self.id = jsonData["id"] as? String ?? ""
        self.name = jsonData["name"] as? String ?? ""
        self.location = Location(jsonData: jsonData["location"] as? [String : Any] ?? ["test": "test"])
    }
}

struct Location {
    var address, postalCode, cc, city, state, country: String
    var lat, long: Float
    var distance: Int
    var formattedAddress = [String]()
    
    init(jsonData: [String: Any]) {
        self.address = jsonData["address"] as? String ?? ""
        self.lat = jsonData["lat"] as? Float ?? 0
        self.long = jsonData["lng"] as? Float ?? 0
        self.distance = jsonData["distance"] as? Int ?? 0
        
        self.postalCode = jsonData["postalCode"] as? String ?? ""
        self.cc = jsonData["cc"] as? String ?? ""
        self.city = jsonData["city"] as? String ?? ""
        self.state = jsonData["state"] as? String ?? ""
        self.country = jsonData["country"] as? String ?? ""
        self.formattedAddress = jsonData["formattedAddress"] as? [String] ?? [String]()
    }
}
