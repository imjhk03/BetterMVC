//
//  DetailLogicController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import Foundation

final class DetailLogicController {
    var movieID: String?
    private let networking = NetworkManager.shared
    
    func load(then handler: @escaping (ViewState<MovieDetail>) -> Void) {
        guard let movieID = self.movieID else {
            handler(.failed)
            return
        }
        networking.request(.detail(movieID: movieID)) { (response: Result<MovieDetail, NetworkError>) in
            switch response {
            case .success(let movie):
                handler(.presenting(movie))
            case .failure(let error):
                handler(.failed)
            }
        }
    }
}
