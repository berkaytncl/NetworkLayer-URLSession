//
//  Endpoint.swift
//  NetworkLayer
//
//  Created by Berkay Tuncel on 2.10.2023.
//

import Foundation

protocol EndpointProtocol{
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String : String]? { get }
    var parameters: [String : Any]? { get }
    
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum Endpoint {
    case getUsers
    case getComments(postID: String)
    case getPosts(title: String, body: String, userID: Int)
}

extension Endpoint: EndpointProtocol {
    var baseURL: String { "https://jsonplaceholder.typicode.com" }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
            
        case .getComments:
            return "/comments"
            
        case .getPosts:
            return "/posts"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
            
        case .getComments:
            return .get
            
        case .getPosts:
            return .post
        }
    }
    
    var header: [String : String]? {
        let header: [String : String] = ["Content-type": "application/json; charset=UTF-8"]
        return header
    }
    
    var parameters: [String : Any]? {
        if case .getPosts(let title, let body, let userID) = self {
            return ["title": title, "body": body, "userId": userID]
        }
        
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else { fatalError("URL error") }

        if case .getComments(let postID) = self {
            components.queryItems = [URLQueryItem(name: "postId", value: postID)]
        }
        
        components.path = path
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return request
    }
}
