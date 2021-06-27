//
//  WebSocketConnect.swift
//  WebSocketProximity
//
//  Created by Ravindra Patidar on 27/06/21.
//

import Foundation
import UIKit

class WebSocketConnect {
    
    var sendMessageClousre: ((String)-> Void)?
    var receiveErrorClousre: (()->Void)?
    
    func connectToWebSocket(url: String) {
        let websocket = WebSocket(url: URL(string: url)!)
        
        websocket.delegate = self
        
        websocket.connect()
    }
}

extension WebSocketConnect: WebSocketConnectionDelegate {
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
        print("WebSocket did receive error: \(error)")
        receiveErrorClousre?()
//        isWebSocketStop = true
//        lastUpdatedValue()
    }
    
    func webSocketDidReceivePong(connection: WebSocketConnection) {
        print("WebSocket did receive pong")
    }
    
    func webSocketDidReceiveMessage(connection: WebSocketConnection, string: String) {
        //print("WebSocket did receive string message: \(string)")
//        lastUpdatedDate = Date()
//        convertStringToJson(jsonStr: string)
         sendMessageClousre?(string)
    }
    
    func webSocketDidReceiveMessage(connection: WebSocketConnection, data: Data) {
        print("WebSocket did receive data message")
    }
}
 
