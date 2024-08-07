import SwiftUI

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}