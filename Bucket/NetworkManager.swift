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

struct BucketItemsResponse: Codable {
    var items: [BucketItem]
}

class NetworkManager {
    static let shared = NetworkManager()
    
    static var session_token: String = ""
    
    // Receive all bucket items for all users for use on Discovery page
    func getAllBucketItems(completion: @escaping (BucketItemsResponse) -> Void) {
        let url = URL(string: "http://34.85.150.149/items/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let jsonString = String(data: data, encoding: .utf8)
                    print("Raw JSON data: \(jsonString ?? "nil")")
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(BucketItemsResponse.self, from: data)
                    
                    completion(response)
                } catch (let error) {
                    print(error.localizedDescription)
                    print("This is where error is")
                }
            }
        }
        task.resume()
    }
    
    // Used to sign in and get the tokens in response
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
    
    // Create account and get proper responser body
    func createAccount(email: String, password: String, completion: @escaping (Result<SessionResponse, Error>) -> Void) {
        let url = URL(string: "http://34.85.150.149/register/")!
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
                    } else if httpResponse.statusCode == 400, let data = data {
                        do {
                            let errorResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            let errorMessage = errorResponse?["message"] as? String ?? "An error occurred"
                            completion(.failure(NSError(domain: "AccountCreationError", code: 400, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                        } catch {
                            completion(.failure(NSError(domain: "AccountCreationError", code: 400, userInfo: [NSLocalizedDescriptionKey: "An error occurred"])))
                        }
                    } else {
                        completion(.failure(NSError(domain: "UnknownError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred"])))
                    }
                } else {
                    completion(.failure(NSError(domain: "NoResponseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No response from server"])))
                }
            }
            task.resume()
    }
    
    // Get the user's individual items
    func getUserItems(session_token: String, completion: @escaping (BucketItemsResponse) -> Void) {
        let url = URL(string: "http://34.85.150.149/user/items/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let setAuthHeader = "Bearer \(session_token)"
        print(setAuthHeader)
        
        // Set authorization header
        request.setValue(setAuthHeader, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let jsonString = String(data: data, encoding: .utf8)
                    print("Raw JSON data: \(jsonString ?? "nil")")
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(BucketItemsResponse.self, from: data)
                    
                    completion(response)
                } catch (let error) {
                    print(error.localizedDescription)
                    print("This is where error is")
                }
            }
        }
        task.resume()
    }
    
}
