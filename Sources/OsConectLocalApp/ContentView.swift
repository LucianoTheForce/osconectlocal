import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
struct ContentView: View {
    @StateObject private var osConnect = OsConectLocal()
    
    var body: some View {
        VStack {
            Text("OsConectLocal")
                .font(.largeTitle)
                .padding()
            
            Text("Status: \(osConnect.connectionStatus)")
                .padding()
            
            Text("Last Message: \(osConnect.lastMessage)")
                .padding()
            
            Button("Connect") {
                osConnect.connect()
            }
            .padding()
            .disabled(osConnect.isConnected)
            
            Button("Disconnect") {
                osConnect.disconnect()
            }
            .padding()
            .disabled(!osConnect.isConnected)
        }
    }
}

@available(iOS 14.0, macOS 11.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}