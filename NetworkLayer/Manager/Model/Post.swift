//
//  Post.swift
//  NetworkLayer
//
//  Created by Berkay Tuncel on 3.10.2023.
//

import Foundation

// MARK: - Post
struct Post: Decodable {
    let id: Int?
    let title: String?
    let body: String?
    let userId: Int?
}
