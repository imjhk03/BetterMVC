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
    
    func testSuccessfulResponse() {
        // Setup our objects
        let session = URLSessionMock()
        let manager = NetworkManager(session: session)
        
        // Create data and tell the session to always return it
        let data = Data(bytes: [0, 1, 0, 1])
        session.data = data
        
        // Create a URL (using the file path API to avoid optionals)
        let url = URL(fileURLWithPath: "url")
        
        // Perform the request and verify the result
        var result: Result<MovieList, NetworkError>?
        manager.request(.trending(time: .day)) { result = $0 }
//        XCTAssertEqual(result, .success(data))
    }

}
