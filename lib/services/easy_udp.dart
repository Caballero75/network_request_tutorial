// import 'dart:convert';

// start_server() async {
//   // Create a EasyUDPSocket and bind to localhost:7777,
//   // Note that you can also manually create a RawDatagramSocket
//   // and pass it to EasyUDPSocket(..) to create a EasyUDPSocket.
//   final socket = await EasyUDPSocket.bind('localhost', 7777);

//   while (true) {
//     // Rather than subscribing to a stream of RawSocketEvents and
//     // calling receive in the callback, which is the case when using
//     // RawDatagramSocket, with EasyUDPSocket, you can get Datagram
//     // on demand with `receive` method.
//     final datagram = await socket.receive();
//     print(
//         'Server received: ${ascii.decode(datagram.data)} from ${datagram.port}');

//     // use `sendBack` to send message to where a Datagram comes from.
//     // This is a shorthand of:
//     // socket.send(somedata, datagram.address, datagram.port);
//     socket.sendBack(datagram, ascii.encode('pong'));
//   }
// }

// start_client(int port) async {
//   final socket = await EasyUDPSocket.bind('localhost', port);
//   socket.send(ascii.encode('ping'), '224.0.0.0', 21928);
//   final resp = await socket.receive();
//   print('Client $port received: ${ascii.decode(resp.data)}');

//   // `close` method of EasyUDPSocket is awaitable.
//   await socket.close();
//   print('Client $port closed');
// }

// main() async {
//   // start_server();
//   await Future.delayed(Duration(seconds: 1));
//   start_client(8001);
//   start_client(8002);
//   start_client(8003);
// }
