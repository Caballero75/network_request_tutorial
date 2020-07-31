import 'dart:io';
import 'package:flutter/material.dart';

// socketConnect();

class SocketConnect extends StatefulWidget {
  @override
  _SocketConnectState createState() => _SocketConnectState();
}

class Conecta {
  static Future<void> socketConnect() async {
    String indexRequest = 'GET / HTTP/1.1\nConnection: close\n\n';

    //connect to google port 80
    Socket.connect('127.0.0.1', 4567).then((socket) {
      print('Connected to: '
          '${socket.remoteAddress.address}:${socket.remotePort}');

      //Establish the onData, and onDone callbacks
      socket.listen((data) {
        print(new String.fromCharCodes(data).trim());
      }, onDone: () {
        print("Done");
        socket.destroy();
      });

      //Send the request
      socket.write(indexRequest);
    });
  }
}

class _SocketConnectState extends State<SocketConnect> {
  String retorno;
  String texto = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.red,
      child: Center(
        child: ElevatedButton(
          onPressed: () => Conecta.socketConnect(),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text(
              "texto",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
