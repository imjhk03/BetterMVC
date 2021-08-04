//
//  BetterMVCTests.swift
//  BetterMVCTests
//
//  Created by Joohee Kim on 21. 06. 22..
//

import XCTest

@testable import BetterMVC

class BetterMVCTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    /// Partial Mocking, intended for successful response
    func testSuccessfulResponse() {
        // Setup our objects
        let session = NetworkSessionMock()
        let manager = NetworkManager(session: session)

        // Create data and tell the session to always return it
        guard let jsonData = JSONReader().read(resource: "TrendingMock") else {
            XCTFail("Failed reading JSON file")
            return
        }
        session.data = jsonData

        var movieList: MovieList?

        do {
            let decoder = JSONDecoder()
            movieList = try decoder.decode(MovieList.self, from: jsonData)
        } catch {
            XCTFail("Failed decode JSON")
            return
        }

        guard let responseData = movieList else {
            XCTFail("Failed, responseData is not equal")
            return
        }

        // Perform the request and verify the result
        var result: Result<MovieList, NetworkError>?
        manager.request(.trending(time: .day)) { result = $0 }
        XCTAssertEqual(result, .success(responseData))
    }

}
