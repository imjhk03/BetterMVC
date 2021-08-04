//
//  NetworkSession.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 06. 23..
//

import Foundation

protocol NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void)
}
