//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Berkay Tuncel on 2.10.2023.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Data Response", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getUsers(completion: @escaping (Result<Users, Error>) -> Void) {
        let endpoint = Endpoint.getUsers
        request(endpoint, completion: completion)
    }
    
    func getComments(postID: String, completion: @escaping (Result<Comments, Error>) -> Void) {
        let endpoint = Endpoint.getComments(postID: postID)
        request(endpoint, completion: completion)
    }
    
    func getPosts(title:String, body: String, userID:Int, completion: @escaping (Result<Post, Error>) -> Void) {
        let endpoint = Endpoint.getPosts(title: title, body: body, userID: userID)
        request(endpoint, completion: completion)
    }
}
