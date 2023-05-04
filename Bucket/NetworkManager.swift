//
//  NetworkManager.swift
//  Bucket
//
//  Created by Nicholas Runje on 5/3/23.
//

import Foundation

struct SessionResponse: Codable {
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
                    
                    completion(response.items)
                } catch (let error) {
                    print(error.localizedDescription)
                    print("This is where error is")
                }
            }
        }
        task.resume()
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<SessionResponse, Error>) -> Void) {
        let url = URL(string: "http://34.85.150.149/login/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String : Any] = [
            "email": email,
            "password": password
            
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200, let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(SessionResponse.self, from: data)
                        completion(.success(response))
                    } catch (let error) {
                        completion(.failure(error))
                    }
                } else if httpResponse.statusCode == 400 {
                    completion(.failure(NSError(domain: "LoginError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Incorrect email or password"])))
                } else {
                    completion(.failure(NSError(domain: "UnknownError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred"])))
                }
            } else {
                completion(.failure(NSError(domain: "NoResponseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No response from server"])))
            }
        }
        task.resume()
    }
    
}
