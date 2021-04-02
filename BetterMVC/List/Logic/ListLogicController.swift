//
//  ListLogicController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import Foundation

final class ListLogicController {
//    private let userID: User.ID
    private let networking = NetworkManager.shared
    
    func load(then handler: @escaping (ViewState<Movie>) -> Void) {
//        let endpoint = Endpoint.user(idL userID)
//
//        networking.request(endpoint) {
//
//        }
        
        networking.loadMovies { result in
            switch result {
            case .success(let movies):
                handler(.presenting(movies))
            case .failure(let error):
                handler(.failed)
            }
        }
        
    }
    
}
