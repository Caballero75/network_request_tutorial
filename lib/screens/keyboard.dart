import 'dart:convert';
import 'dart:io' show WebSocket;
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/notas.dart';

class WebSocketClient {
  static Future<WebSocket> clientConnect() async {
    final ws = await WebSocket.connect('ws://192.168.0.21:8000').catchError(
      (onError) => print('[!]Error -- ${onError.toString()}'),
    );
    print(ws.readyState);
    return ws;
  }

  static sendMessage(
    Future<WebSocket> fWs,
    int midiNote,
    String action,
  ) async {
    final WebSocket ws = await fWs;
    // our websocket server runs on ws://localhost:8000
    if (ws?.readyState == WebSocket.open) {
      print(ws?.readyState);

      // as soon as websocket is connected and ready for use, we can start talking to other end
      ws.add(json.encode({
        "midiNote": midiNote,
        "action": action,
      })); // this is the JSON data format to be transmitted
      // ws.listen(
      //   /// [ Listem to server response ???]
      //   // gives a StreamSubscription
      //   (data) {
      //     print(data);
      //     /*
      //     //#region <nome>
      //     // print('\t\t -- ${Map<String, String>.from(json.decode(data))}');
      //     // // listen for incoming data and show when it arrives
      //     // if (ws.readyState == WebSocket.open)
      //     //   // checking whether connection is open or not,
      //     //   // is required before writing anything on socket
      //     //   ws.add(json.encode({
      //     //     'data': 'from client at ${DateTime.now().toString()}',
      //     //   }));
      //     //#endregion

      //     */
      //   },
      //   onDone: () {
      //     print('[+]Done :)');
      //     ws.close();
      //   },
      //   onError: (err) => print('[!]Error -- ${err.toString()}'),
      //   cancelOnError: true,
      // );
    } else
      print('[!]Connection Denied');
    // in case, if server is not running now
  }

  static Future<void> getConnection() async {
    final ws = await WebSocketClient.clientConnect();
    return ws;
  }
}

class Keyboard extends StatelessWidget {
  double topo;
  bool sharp;
  @override
  Widget build(BuildContext context) {
    final ws = WebSocketClient.clientConnect();
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                for (int i = 0; i < mapaNotas.length; i++)
                  Container(
                    color: Colors.blue,
                    child: Text("Tecla"),
                  )
                // Tecla(ws: ws, midiNote: i, action: 'down'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tecla extends StatelessWidget {
  final Future<WebSocket> ws;
  final int midiNote;
  final String action;

  const Tecla({
    Key key,
    @required this.ws,
    @required this.midiNote,
    @required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        print("onTapDown");
        WebSocketClient.sendMessage(ws, midiNote, 'down');
      },
      onTapUp: (_) {
        print("onTapUp");
        WebSocketClient.sendMessage(ws, midiNote, 'up');
      },
      child: Container(
        color: Colors.amber,
        child: Material(
          borderRadius: BorderRadius.circular(30),
          borderOnForeground: false,
          color: Colors.amber,
          child: InkWell(
            // onTap: () => {},
            borderRadius: BorderRadius.circular(30),
            splashColor: Colors.black,
            highlightColor: Colors.greenAccent,
            child: Container(
              child: Center(
                child: Text(
                  '$midiNote',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
