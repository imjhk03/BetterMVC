//
//  Movie.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import Foundation

struct MoviewList: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable {
    
    private(set) var adult: Bool
    private(set) var backdrop_path: String?
    private(set) var genre_ids: [Int]
    private(set) var id: Int
    private(set) var original_language: String?
    private(set) var original_title: String?
    private(set) var overview: String?
    private(set) var popularity: Double
    private(set) var poster_path: String?
    private(set) var release_date: String?
    private(set) var title: String?
    private(set) var video: Bool
    private(set) var vote_average: Double
    private(set) var vote_count: Int
    
}
