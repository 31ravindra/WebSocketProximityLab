//
//  WebSocketManagerTests.swift
//  WebSocketProximityTests
//
//  Created by Ravindra Patidar on 26/06/21.
//

import XCTest
@testable import WebSocketProximity

final class WebSocketManagerTests: XCTestCase {
    final let testUrl = URL(string: "wss://echo.WebSocket.org")!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSendStringMessage() {
        let websocket = WebSocket(url: testUrl)
        
        let expectation = XCTestExpectation(description: "Receive a message from the remote server")
        
        let delegate = WebSocketTestDelegate()
        delegate.asyncExpectation = expectation
        
        websocket.delegate = delegate
        websocket.connect()
        websocket.send(string: "Test")
       
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSendDataMessage() {
        let websocket = WebSocket(url: testUrl)
        
        let expectation = XCTestExpectation(description: "Receive a message from the remote server")
        
        let delegate = WebSocketTestDelegate()
        delegate.asyncExpectation = expectation
        
        websocket.delegate = delegate
        websocket.connect()
        websocket.send(data: "Test".data(using: .utf8)!)
       
        wait(for: [expectation], timeout: 10.0)
    }

    static var allTests = [
        ("testSendStringMessage", testSendStringMessage),
        ("testSendDataMessage", testSendDataMessage)
    ]

}
