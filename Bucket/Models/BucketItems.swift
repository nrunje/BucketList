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

struct BucketItem: Codable, Identifiable {
    let id: Int
    let user: String
    let name: String
    let location: String
    let likes: Int
    let date: String
    let note: String
    let photo: String
    let is_experience: Bool
}


var myBucketList: [BucketItem] = []

let demoBucketItems: [BucketItem] = [
    BucketItem(id: 0, user: "username", name: "Travel to Paris", location: "Paris", likes: 1, date: "7/12/2023", note: "Visit the great city of France!", photo: "", is_experience: false),
    BucketItem(id: 1, user: "username", name: "Get married", location: "", likes: 1, date: "5/20/2023", note: "Get comm", photo: "", is_experience: true)
]
