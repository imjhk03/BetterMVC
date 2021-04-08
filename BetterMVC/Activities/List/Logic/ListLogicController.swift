//
//  ListLogicController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import Foundation

final class ListLogicController {
    private let networking = NetworkManager.shared
    
    func load(then handler: @escaping (ViewState<[Movie]>) -> Void) {
        networking.request(.trending(time: .week)) { (response: Result<MovieList, NetworkError>) in
            switch response {
            case .success(let response):
                let movies = response.results
                handler(.presenting(movies))
            case .failure(let error):
                handler(.failed)
            }
        }
    }
    
}
