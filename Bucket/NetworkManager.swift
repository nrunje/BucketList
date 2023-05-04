//
//  NetworkManager.swift
//  Bucket
//
//  Created by Nicholas Runje on 5/3/23.
//

import Foundation

struct Session: Codable {
    let session_token: String
    let session_expiration: String
    let update_token: String
}

class NetworkManager {
    static let shared = NetworkManager()
    
    static var session_token: String = ""
    
    func getAllBucketItems(completion: @escaping ([BucketItem]) -> Void) {
        let url = URL(string: "http://34.85.150.149/items/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(BucketItemsResponse.self, from: data)
                    
                    completion(response.bucketItems)
                } catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func signIn(completion: @escaping (String) -> Void) {
        let url = URL(string: "http://34.85.150.149/login/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Session.self, from: data)
                    
                    completion(response.session_token)
                } catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
}
