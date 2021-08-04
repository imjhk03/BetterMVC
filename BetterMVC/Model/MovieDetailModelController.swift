//
//  MovieDetailModelController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 08..
//

import Foundation

final class MovieDetailModelController {
    private(set) var movieDetail: MovieDetail

    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
}

extension MovieDetailModelController {

    var isFavorite: Bool {
        return false
    }

//    func save() { }

// 아래는 예시, 상품 찜, 스토어 찜 등과 같은 업데이트가 필요한 곳에 사용하면 좋을 것 같다.
//    func update(then handler: @escaping (Outcome) -> Void) {
//        let url = Endpoint.user.url
//
//        dataLoader.loadData(from: url) { [weak self] result in
//            do {
//                switch result {
//                case .success(let data):
//                    let decoder = JSONDecoder()
//                    self?.user = try decoder.decode(User.self, from: data)
//                    handler(.success)
//                case .failure(let error):
//                    handler(.failure(error))
//                }
//            } catch {
//                handler(.failure(error))
//            }
//        }
//    }

}
