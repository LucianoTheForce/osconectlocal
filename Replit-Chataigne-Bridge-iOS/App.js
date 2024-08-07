import React, { useState, useEffect, useCallback } from 'react';
import { StyleSheet, Text, View, Button, SafeAreaView, TextInput } from 'react-native';
import dgram from 'react-native-udp';
import NetInfo from "@react-native-community/netinfo";

const WEBSOCKET_URL = 'wss://websocket-luciano15.replit.app';

export default function App() {
  const [status, setStatus] = useState('Disconnected');
  const [lastMessage, setLastMessage] = useState('');
  const [socket, setSocket] = useState(null);
  const [oscPort, setOscPort] = useState('');
  const [localIpAddress, setLocalIpAddress] = useState('');

  useEffect(() => {
    NetInfo.fetch().then(state => {
      if (state.type === 'wifi' && state.details.ipAddress) {
        setLocalIpAddress(state.details.ipAddress);
      }
    });
  }, []);

  const connect = useCallback(() => {
    const ws = new WebSocket(WEBSOCKET_URL);

    ws.onopen = () => {
      setStatus('Connected');
      setSocket(ws);
    };

    ws.onmessage = (event) => {
      setLastMessage(event.data);
      sendOSCMessage(event.data);
    };

    ws.onerror = (error) => {
      console.log('WebSocket error: ', error);
      setStatus('Error: ' + error.message);
    };

    ws.onclose = () => {
      setStatus('Disconnected');
      setSocket(null);
    };
  }, []);

  const disconnect = useCallback(() => {
    if (socket) {
      socket.close();
    }
  }, [socket]);

  const sendOSCMessage = (message) => {
    if (!oscPort) {
      console.log('OSC port not set');
      return;
    }

    const socket = dgram.createSocket('udp4');

    const buffer = Buffer.from(message);
    socket.send(buffer, 0, buffer.length, parseInt(oscPort), '127.0.0.1', (err) => {
      if (err) console.log('Error sending OSC message:', err);
      socket.close();
    });
  };

  useEffect(() => {
    return () => {
      if (socket) {
        socket.close();
      }
    };
  }, [socket]);

  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>Replit-App Bridge</Text>
      <Text style={styles.status}>Status: {status}</Text>
      <Text style={styles.message}>Last Message: {lastMessage}</Text>
      <Text style={styles.ipAddress}>Local IP: {localIpAddress}</Text>
      <TextInput
        style={styles.input}
        onChangeText={setOscPort}
        value={oscPort}
        placeholder="Enter OSC Port"
        keyboardType="numeric"
      />
      <View style={styles.buttonContainer}>
        <Button
          title="Connect"
          onPress={connect}
          disabled={status === 'Connected' || !oscPort}
        />
        <Button
          title="Disconnect"
          onPress={disconnect}
          disabled={status !== 'Connected'}
        />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  status: {
    fontSize: 18,
    marginBottom: 10,
  },
  message: {
    fontSize: 16,
    marginBottom: 10,
  },
  ipAddress: {
    fontSize: 16,
    marginBottom: 20,
  },
  input: {
    height: 40,
    width: '80%',
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 20,
    paddingHorizontal: 10,
  },
  buttonContainer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    width: '100%',
  },
});