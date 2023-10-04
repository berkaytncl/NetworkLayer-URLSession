//
//  Comment.swift
//  NetworkLayer
//
//  Created by Berkay Tuncel on 3.10.2023.
//

import Foundation

typealias Comments = [CommentElement]

// MARK: - CommentElement
struct CommentElement: Decodable {
    let postID: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
