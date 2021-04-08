//
//  Movie.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import Foundation

protocol Model: Codable { }

enum ViewState<Model> {
    case loading
    case presenting(Model)
    case failed
}

struct MovieList: Model {
    let page: Int
    let results: [Movie]
}

struct Movie: Model {
    
    private(set) var adult: Bool
    private(set) var backdrop_path: String?
    private(set) var genre_ids: [Int]
    private(set) var id: Int
    private(set) var original_title: String
    private(set) var overview: String?
    private(set) var popularity: Double
    private(set) var poster_path: String?
    private(set) var release_date: String   // format: date
    private(set) var runtime: Int?
    private(set) var title: String
    private(set) var video: Bool
    private(set) var vote_average: Double
    private(set) var vote_count: Int
    
}

struct MovieDetail: Model {
    
    private(set) var adult: Bool
    private(set) var backdrop_path: String?
    private(set) var genres: [Genre]
    private(set) var id: Int
    private(set) var original_title: String
    private(set) var overview: String?
    private(set) var popularity: Double
    private(set) var poster_path: String?
    private(set) var release_date: String   // format: date
    private(set) var runtime: Int?
    private(set) var title: String
    private(set) var video: Bool
    private(set) var vote_average: Double
    private(set) var vote_count: Int
    
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path
        case genres
        case id
        case original_title
        case overview
        case popularity
        case poster_path
        case release_date
        case runtime
        case title
        case video
        case vote_average
        case vote_count
    }
    
}

extension MovieDetail {
    static var current: MovieDetail?
}
