import 'dart:io' show HttpServer, HttpRequest, WebSocket, WebSocketTransformer;
import 'dart:convert' show json;

void main() {
  WebSocketServer.connect();
}

class WebSocketServer {
  static connect() {
    HttpServer.bind('192.168.0.21', 8000).then((HttpServer server) {
      print('[+]WebSocket listening at -- ws://192.168.0.21:8000/');
      server.listen((HttpRequest request) {
        WebSocketTransformer.upgrade(request).then((WebSocket ws) {
          ws.listen(
            (data) {
              print('''${request?.connectionInfo?.remoteAddress} 
                  -- ${Map<String, String>.from(json.decode(data))}''');
              if (ws.readyState == WebSocket.open) {}
              // checking connection state helps to avoid unprecedented errors
              /// [Server response ???]
              // ws.add(json.encode({
              //   'data': 'from server at ${DateTime.now().toString()}',
              // }));
            },
            onDone: () => print('[+]Done :)'),
            onError: (err) => print('[!]Error -- ${err.toString()}'),
            cancelOnError: true,
          );
        }, onError: (err) => print('[!]Error -- ${err.toString()}'));
      }, onError: (err) => print('[!]Error -- ${err.toString()}'));
    }, onError: (err) => print('[!]Error -- ${err.toString()}'));
  }
}
