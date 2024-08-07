import SwiftUI
import Foundation
import Network

@main
struct ReplitChataigneBridgeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @StateObject private var bridgeManager = BridgeManager()
    
    var body: some View {
        VStack {
            Text("Replit-Chataigne Bridge")
                .font(.title)
            
            Text("Status: \(bridgeManager.connectionStatus)")
                .padding()
            
            Text("Last Message: \(bridgeManager.lastMessage)")
                .padding()
            
            Button("Connect") {
                bridgeManager.connect()
            }
            .padding()
            .disabled(bridgeManager.isConnected)
            
            Button("Disconnect") {
                bridgeManager.disconnect()
            }
            .padding()
            .disabled(!bridgeManager.isConnected)
        }
    }
}

class BridgeManager: ObservableObject {
    @Published var connectionStatus = "Disconnected"
    @Published var lastMessage = ""
    @Published var isConnected = false
    
    private var webSocketTask: URLSessionWebSocketTask?
    private let websocketUrl = URL(string: "wss://websocket-luciano15.replit.app")!
    
    private let oscHost = "127.0.0.1"
    private let oscPort: UInt16 = 12000
    private var oscConnection: NWConnection?
    
    func connect() {
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: websocketUrl)
        webSocketTask?.resume()
        
        isConnected = true
        connectionStatus = "Connected"
        
        setupOSCConnection()
        receiveMessage()
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
                    DispatchQueue.main.async {
                        self?.lastMessage = text
                        self?.sendOSCMessage(text)
                    }
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    print("Unknown message type received")
                }
                
                self?.receiveMessage() // Continue receiving messages
            }
        }
    }
    
    private func setupOSCConnection() {
        let host = NWEndpoint.Host(oscHost)
        let port = NWEndpoint.Port(integerLiteral: oscPort)
        oscConnection = NWConnection(host: host, port: port, using: .udp)
        
        oscConnection?.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("OSC connection ready")
            case .failed(let error):
                print("OSC connection failed: \(error)")
            default:
                break
            }
        }
        
        oscConnection?.start(queue: .global())
    }
    
    private func sendOSCMessage(_ message: String) {
        let oscAddress = "/message"
        var oscMessage = Data()
        
        // OSC Address
        oscMessage.append(oscAddress.data(using: .utf8)!)
        oscMessage.append(0) // Null terminator
        while oscMessage.count % 4 != 0 {
            oscMessage.append(0) // Padding
        }
        
        // Type tag string
        oscMessage.append(",s".data(using: .utf8)!)
        oscMessage.append(0) // Null terminator
        while oscMessage.count % 4 != 0 {
            oscMessage.append(0) // Padding
        }
        
        // OSC Argument (the message)
        oscMessage.append(message.data(using: .utf8)!)
        oscMessage.append(0) // Null terminator
        while oscMessage.count % 4 != 0 {
            oscMessage.append(0) // Padding
        }
        
        oscConnection?.send(content: oscMessage, completion: .contentProcessed({ error in
            if let error = error {
                print("Error sending OSC message: \(error)")
            } else {
                print("OSC message sent successfully")
            }
        }))
    }
}