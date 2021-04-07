//
//  NetworkManager.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import Foundation

final class NetworkManager {
    
    static let shared       = NetworkManager()
    private let baseURL     = "https://api.themoviedb.org/3/movie/550?api_key=\(API_KEY)"
    private let scheme = "https"
    private let host = "api.themoviedb.org"
    private let basePath = "/3"
    
    private let testURL = "https://api.themoviedb.org/3/discover/movie?api_key=\(API_KEY)&language=ko-KR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
    
    func loadMovies(_ handler: @escaping (Result<[Movie], NetworkError>) -> Void) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = basePath + "/discover/movie"
        
        guard let url = URL(string: testURL) else {
            preconditionFailure("Failed to construct URL")
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                handler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(MoviewList.self, from: data)
                handler(.success(responseData.results))
            } catch {
                handler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
