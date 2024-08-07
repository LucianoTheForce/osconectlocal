import Foundation
import Network

@available(iOS 14.0, macOS 11.0, *)
class OsConectLocal: ObservableObject {
    @Published var connectionStatus = "Disconnected"
    @Published var lastMessage = ""
    @Published var isConnected = false
    
    private var webSocketTask: URLSessionWebSocketTask?
    private let websocketUrl = URL(string: "wss://websocket-luciano15.replit.app")!
    
    private let oscHost = "127.0.0.1"
    private let oscPort = 8000
    private var oscConnection: NWConnection?
    
    func connect() {
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: websocketUrl)
        webSocketTask?.resume()
        
        isConnected = true
        connectionStatus = "Connected"
        
        receiveMessage()
        setupOSCConnection()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        oscConnection?.cancel()
        
        isConnected = false
        connectionStatus = "Disconnected"
    }
    
    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
                self?.connectionStatus = "Error: \(error.localizedDescription)"
                self?.isConnected = false
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Received string: \(text)")
                    self?.lastMessage = text
                    // Here you would parse the message and send it as OSC
                    self?.sendOSCMessage(text)
                case .data(let data):
                    print("Received data: \(data)")
                @unknown default:
                    break
                }
                
                self?.receiveMessage()
            }
        }
    }
    
    private func setupOSCConnection() {
        let host = NWEndpoint.Host(oscHost)
        let port = NWEndpoint.Port(integerLiteral: UInt16(oscPort))
        oscConnection = NWConnection(host: host, port: port, using: .udp)
        
        oscConnection?.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("OSC connection ready")
            case .failed(let error):
                print("OSC connection failed with error: \(error)")
            default:
                break
            }
        }
        
        oscConnection?.start(queue: .global())
    }
    
    private func sendOSCMessage(_ message: String) {
        // Here you would construct your OSC message based on the received WebSocket message
        let oscMessage = "/example/path \(message)".data(using: .utf8)
        
        oscConnection?.send(content: oscMessage, completion: .contentProcessed({ error in
            if let error = error {
                print("Error sending OSC message: \(error)")
            } else {
                print("OSC message sent successfully")
            }
        }))
    }
}