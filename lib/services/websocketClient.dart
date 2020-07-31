import 'dart:io' show WebSocket;
import 'dart:convert' show json;

import 'package:flutter/material.dart';

class WebSocketClient {
  static Future<WebSocket> clientConnect() async {
    final ws = await WebSocket.connect('ws://192.168.0.21:8000').catchError(
      (onError) => print('[!]Error -- ${onError.toString()}'),
    );
    return ws;
  }

  static sendMessage(
    Future<WebSocket> fWs,
    String msg,
  ) async {
    final WebSocket ws = await fWs;
    // our websocket server runs on ws://localhost:8000
    if (ws?.readyState == WebSocket.open) {
      // as soon as websocket is connected and ready for use, we can start talking to other end
      ws.add(json.encode({
        '$msg': 'from client at ${DateTime.now().toString()}',
      })); // this is the JSON data format to be transmitted
      ws.listen(
        /// [ Listem to server response ???]
        // gives a StreamSubscription
        (data) {
          // print('\t\t -- ${Map<String, String>.from(json.decode(data))}');
          // // listen for incoming data and show when it arrives
          // if (ws.readyState == WebSocket.open)
          //   // checking whether connection is open or not,
          //   // is required before writing anything on socket
          //   ws.add(json.encode({
          //     'data': 'from client at ${DateTime.now().toString()}',
          //   }));
        },
        onDone: () {
          print('[+]Done :)');
          ws.close();
        },
        onError: (err) => print('[!]Error -- ${err.toString()}'),
        cancelOnError: true,
      );
    } else
      print('[!]Connection Denied');
    // in case, if server is not running now
  }
}

class WSClient extends StatefulWidget {
  @override
  _WSClientState createState() => _WSClientState();
}

class _WSClientState extends State<WSClient> {
  bool pressed = false;
  Future<WebSocket> ws = WebSocketClient.clientConnect();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(
              onPressed: () =>
                  WebSocketClient.sendMessage(ws, '!!!!!Mensagem!!!!'),
              child: Text(
                "WebSocket",
                style: TextStyle(fontSize: 30),
              ),
            ),
            RaisedButton(
              splashColor: Colors.deepPurple,
              color: pressed ? Colors.red : Colors.blue[300],
              onPressed: () {
                setState(() {
                  WebSocketClient.sendMessage(ws, '!!!!!Outra!!!!');
                  // pressed = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "!!!!!!!!!!!!",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
