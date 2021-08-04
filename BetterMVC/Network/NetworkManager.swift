//
//  NetworkManager.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import Foundation

class NetworkManager {

    static let shared       = NetworkManager()
    static let scheme       = "https"
    static let host         = "api.themoviedb.org"
    static let basePath     = "/3"

    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session

        // Register the custom URL Protocol.
        URLProtocol.registerClass(PrintProtocol.self)

        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses?.insert(PrintProtocol.self, at: 0)
    }

    func request<T: Decodable>(_ endpoint: EndPoint,
                               then handler: @escaping (Result<T, NetworkError>) -> Void) {

        guard let url = endpoint.url else {
            handler(.failure(.invalidURL))
            return
        }

        session.loadData(from: url) { data, _ in
            guard let data = data else {
                handler(.failure(.invalidData))
                return
            }

            print("✅ Request Success: \(url.absoluteString)")

            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(T.self, from: data)
                handler(.success(responseData))
            } catch {
                print("Invalid JSON")
                handler(.failure(.invalidData))
            }
        }
    }
}

extension URLSession: NetworkSession {

    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }

        task.resume()
    }

}

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?

    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }

}
