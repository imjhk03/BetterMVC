//
//  ListLogicController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import Foundation

final class ListLogicController {
    private let networking = NetworkManager.shared
    
    func load(then handler: @escaping (ViewState<Movie>) -> Void) {
        handler(.loading)
        
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
