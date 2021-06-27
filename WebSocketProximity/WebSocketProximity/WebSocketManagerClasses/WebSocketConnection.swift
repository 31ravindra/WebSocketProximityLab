//
//  WebSocketConnection.swift
//  WebSocketProximity
//
//  Created by Ravindra Patidar on 26/06/21.
//



/// Defines a websocket connection.
public protocol WebSocketConnection {
    
    /// Connect to the websocket.
    func connect()
    
    /// Send a UTF-8 formatted `String` over the websocket.
    /// - Parameters:
    ///   - string: The `String` that will be sent.
    func send(string: String)
    
    /// Send some `Data` over the websocket.
    /// - Parameters:
    ///   - data: The `Data` that will be sent.
    func send(data: Data)
    
    /// Ping the websocket once.
    func ping()
    
    /// Disconnect from the websocket.
    /// - Parameters:
    ///   - closeCode: The code to use when closing the websocket connection.
    func disconnect(closeCode: NWProtocolWebSocket.CloseCode)
    
    var delegate: WebSocketConnectionDelegate? { get set }
}
