/**
  file: serverexample.dart
  author: James Slocum

  Simple server that will 
     1) accept a new connection
     2) say hello
     3) close the connection
*/

import 'dart:io';

void main() {
  ServerSocket.bind(InternetAddress.anyIPv4, 4567).then((
    ServerSocket server,
  ) {
    server.listen(handleClient);
  });
}

void handleClient(Socket client) {
  print('Connection from '
      '${client.remoteAddress.address}:${client.remotePort}');

  client.write("!!!!!! from simple server!\n");
  client.close();
}
