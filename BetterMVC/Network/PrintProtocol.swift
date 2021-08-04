//
//  PrintProtocol.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 08. 05..
//  A custom protocol for logging outgoing requests.
//

import Foundation

final class PrintProtocol: URLProtocol {

    override class func canInit(with request: URLRequest) -> Bool {
        // Print valuable request information.
        print("💬 Running request: \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")

        // By returning 'false', this URLProtocol will do noting less than logging.
        return false
    }

}
