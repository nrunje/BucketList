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

public class BucketItem: Identifiable {
    var title: String
    var location: String
    var photo: String
    var date: String
    var note: String
    var typeOfActivity: ActivityType
    
    init(title: String, location: String, photo: String, date: String, note: String, typeOfActivity: ActivityType) {
        self.title = title
        self.location = location
        self.photo = photo
        self.date = date
        self.note = note
        self.typeOfActivity = typeOfActivity
    }
}

let demoBucketItems: [BucketItem] = [
    BucketItem(title: "Visit Paris", location: "Paris, France", photo: photoPlaceholder, date: "2023-06-01", note: "Stay in a cute Parisian apartment and eat lots of croissants!", typeOfActivity: .Location),
    BucketItem(title: "Learn to play guitar", location: "", photo: photoPlaceholder, date: "", note: "Take lessons and practice every day until I can play my favorite songs.", typeOfActivity: .Experience),
    BucketItem(title: "Get married", location: "New York City", photo: photoPlaceholder, date: "2024-09-15", note: "Plan the perfect wedding and celebrate with family and friends.", typeOfActivity: .Experience),
    BucketItem(title: "Hike the Appalachian Trail", location: "Maine to Georgia", photo: photoPlaceholder, date: "", note: "Take on the challenge of hiking over 2,000 miles through the Appalachian Mountains.", typeOfActivity: .Location),
    BucketItem(title: "Visit all 50 US states", location: "", photo: photoPlaceholder, date: "", note: "Embark on a road trip to explore every state in the USA.", typeOfActivity: .Location),
    BucketItem(title: "Learn a new language", location: "", photo: photoPlaceholder, date: "", note: "Become fluent in a language I've always wanted to learn.", typeOfActivity: .Experience),
    BucketItem(title: "Skydive", location: "Las Vegas, Nevada", photo: photoPlaceholder, date: "2025-07-01", note: "Experience the thrill of jumping out of a plane at 12,000 feet!", typeOfActivity: .Experience),
    BucketItem(title: "Go on a safari", location: "Serengeti, Tanzania", photo: photoPlaceholder, date: "2024-02-15", note: "See lions, elephants, and other incredible wildlife up close.", typeOfActivity: .Experience),
    BucketItem(title: "Volunteer abroad", location: "Honduras", photo: photoPlaceholder, date: "2023-12-01", note: "Help build homes and provide aid to people in need in a developing country.", typeOfActivity: .Experience)
]
