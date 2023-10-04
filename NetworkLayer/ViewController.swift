//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Berkay Tuncel on 2.10.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsers()
        getComments(id: 1)
        getPosts(title: "title", body: "body", id: 5)
    }
}

extension ViewController {
    private func getUsers() {
        NetworkManager.shared.getUsers { response in
            switch response {
            case .success(let users):
                users.forEach { print($0.name ?? "unknown") }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getComments(id: Int) {
        NetworkManager.shared.getComments(postID: String(id)) { response in
            switch response {
            case .success(let comments):
                comments.forEach { print($0.email ?? "unknown") }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func getPosts(title:String, body:String, id:Int){
        NetworkManager.shared.getPosts(title: title, body: body, userID: id) { response in
            switch response {
            case .success(let post):
                print(post.body ?? "N/A")
                print(post.title ?? "N/A")
                print(post.id ?? -1)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
