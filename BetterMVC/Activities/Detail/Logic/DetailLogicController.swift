//
//  DetailLogicController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import Foundation

final class DetailLogicController {
    private let movieID = "791373"
    private let networking = NetworkManager.shared
    
    func load(then handler: @escaping (MovieDetail.State) -> Void) {
        networking.request(.detail(movieID: movieID)) { (response: Result<MovieDetail, NetworkError>) in
            switch response {
            case .success(let movie):
                print(movie)
                handler(.presenting(movie))
            case .failure(let error):
                handler(.failed)
            }
        }
    }
}
