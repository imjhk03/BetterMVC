//
//  TrendingLogicController.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 06. 22..
//

import Foundation

final class TrendingLogicController {
    var time: Time = .day
    private var todayMovies = [Movie]()
    private var thisWeekMovies = [Movie]()
    private let networking = NetworkManager.shared
    private var hasLoaded: Bool = false

    func load(then handler: @escaping (ViewState<[Movie]>) -> Void) {
        if hasLoaded { return }
        if !todayMovies.isEmpty && !thisWeekMovies.isEmpty {
            switch time {
            case .day:
                handler(.presenting(todayMovies))
            case .week:
                handler(.presenting(thisWeekMovies))
            }
            return
        }

        networking.request(.trending(time: time)) { [weak self] (response: Result<MovieList, NetworkError>) in
            guard let self = self else { return }

            switch response {
            case .success(let response):
                let movies = response.results

                switch self.time {
                case .day:
                    self.todayMovies = movies
                case .week:
                    self.thisWeekMovies = movies
                }
                
                self.hasLoaded = true
                handler(.presenting(movies))
            case .failure:
                handler(.failed)
            }
        }
    }

}

extension TrendingLogicController: TrendingDataSourceDataProvider {
    func item(for section: TrendingDataSource.Section) -> TrendingDataSource.Item {
        switch section {
        case .main:
            switch time {
            case .day:
                return .init(movies: todayMovies)
            case .week:
                return .init(movies: thisWeekMovies)
            }
        }
    }
}
