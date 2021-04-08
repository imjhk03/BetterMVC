//
//  NetworkManager.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import Foundation

struct EndPoint {
    let path: String
    let queryItems: [URLQueryItem]
}

enum Sorting: String {
    case popularityDesc = "popularity.desc"
}

enum Time: String {
    case day
    case week
}

extension EndPoint {
    static func discover(page: Int, sortedBy sorting: Sorting = .popularityDesc) -> EndPoint {
        return EndPoint(
            path: "/discover/movie",
            queryItems: [
                URLQueryItem(name: "api_key", value: API_KEY),
                URLQueryItem(name: "language", value: "ko-KR"),
                URLQueryItem(name: "sort_by", value: sorting.rawValue),
                URLQueryItem(name: "page", value: String(page))
            ]
        )
    }
    
    static func detail(movieID: String) -> EndPoint {
        return EndPoint(
            path: "/movie/\(movieID)",
            queryItems: [
                URLQueryItem(name: "api_key", value: API_KEY),
                URLQueryItem(name: "language", value: "ko-KR")
            ]
        )
    }
    
    static func trending(time: Time) -> EndPoint {
        return EndPoint(
            path: "/trending/movie/\(time.rawValue)",
            queryItems: [
                URLQueryItem(name: "api_key", value: API_KEY),
                URLQueryItem(name: "language", value: "ko-KR")
            ]
        )
    }
    
}

extension EndPoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = NetworkManager.scheme
        components.host = NetworkManager.host
        components.path = NetworkManager.basePath + path
        components.queryItems = queryItems
        
        return components.url
    }
}

final class NetworkManager {
    
    static let shared       = NetworkManager()
    static let scheme       = "https"
    static let host         = "api.themoviedb.org"
    static let basePath     = "/3"
    
    private let testDetailURL = "https://api.themoviedb.org/3/movie/791373?api_key=\(API_KEY)&language=ko-KR"
    
    
    func request<T: Decodable>(_ endpoint: EndPoint,
                 then handler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            return handler(.failure(.invalidURL))
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                handler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(T.self, from: data)
                handler(.success(responseData))
            } catch {
                print("Invalid JSON")
                handler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
