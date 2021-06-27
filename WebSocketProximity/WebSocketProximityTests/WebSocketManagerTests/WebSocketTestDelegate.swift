//
//  WebSocketTestDelegate.swift
//  WebSocketProximityTests
//
//  Created by Ravindra Patidar on 26/06/21.
//

import XCTest
import Network
@testable import WebSocketProximity

class WebSocketTestDelegate: WebSocketConnectionDelegate {
    
    var asyncExpectation: XCTestExpectation?
    
    func webSocketDidConnect(connection: WebSocketConnection) {
        print("WebSocket did connect")
    }
    
    func websocketDidPrepare(connection: WebSocketConnection) {
        print("WebSocket did prepare")
    }
    
    func webSocketDidDisconnect(connection: WebSocketConnection, closeCode: NWProtocolWebSocket.CloseCode, reason: Data?) {
        print("WebSocket did disconnect")
    }
    
    func websocketDidCancel(connection: WebSocketConnection) {
        print("WebSocket did cancel")
    }
    
    func webSocketDidReceiveError(connection: WebSocketConnection, error: Error) {
        print("WebSocket did receive error \(error)")
    }
    
    func webSocketDidReceivePong(connection: WebSocketConnection) {
        print("WebSocket did receive pong")
    }
    
    func webSocketDidReceiveMessage(connection: WebSocketConnection, string: String) {
        guard let expectation = asyncExpectation else {
            XCTFail("WebSocketTestDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        print("WebSocket did receive string message")
        expectation.fulfill()
    }
    
    func webSocketDidReceiveMessage(connection: WebSocketConnection, data: Data) {
        guard let expectation = asyncExpectation else {
            XCTFail("WebSocketTestDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        print("WebSocket did receive data message")
        expectation.fulfill()
    }
}
