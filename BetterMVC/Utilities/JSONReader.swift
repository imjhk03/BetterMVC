//
//  JSONReader.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 06. 23..
//

import Foundation

class JSONReader {
    
    func read(resource: String) -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: resource, ofType: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//            return try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            return data
        } catch {
            return nil
        }
    }
    
}
