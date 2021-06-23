//
//  EndPoint.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 06. 23..
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
    
    static func popular() -> EndPoint {
        return EndPoint(
            path: "/movie/popular",
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
