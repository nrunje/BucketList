//
//  BucketItems.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/25/23.
//

import Foundation

public enum ActivityType {
    case Location
    case Experience
}

let photoPlaceholder = "glacier"

struct BucketItem: Identifiable {
    
    public var id: Int
    var user_id: Int
    var name: String
    var location: String
    var likes: Int
    var date: String
    var notes: String
    var is_experience: Bool
    
    init(id: Int, user_id: Int, name: String, location: String, likes: Int, date: String, notes: String, is_experience: Bool) {
        self.id = id
        self.user_id = user_id
        self.name = name
        self.location = location
        self.likes = likes
        self.date = date
        self.notes = notes
        self.is_experience = is_experience
    }
}

var myBucketList: [BucketItem] = []

let demoBucketItems: [BucketItem] = [
    BucketItem(id: 0, user_id: 0, name: "Travel to Paris", location: "Paris", likes: 1, date: "7/12/2023", notes: "Visit the great city of France!", is_experience: false),
    BucketItem(id: 1, user_id: 1, name: "Get married", location: "", likes: 1, date: "5/20/2023", notes: "Get comm", is_experience: true)
]
