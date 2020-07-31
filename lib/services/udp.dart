// import 'dart:io';

// import 'package:udp/udp.dart';

// main() async {
//   // MULTICAST
//   var multicastEndpoint =
//       Endpoint.multicast(InternetAddress("224.0.0.0"), port: Port(21928));

//   var receiver = await UDP.bind(multicastEndpoint);

//   var sender = await UDP.bind(Endpoint.any());

//   // unawaited(receiver.listen((datagram) {
//   //   if (datagram != null) {
//   //     var str = String.fromCharCodes(datagram?.data);

//   //     stdout.write(str);
//   //   }
//   // }));

//   await sender.send("Foo".codeUnits, multicastEndpoint);
//   await Future.delayed(Duration(seconds: 5));
//   await sender.send("Foo".codeUnits, multicastEndpoint);
//   await Future.delayed(Duration(seconds: 5));
//   await sender.send("Foo".codeUnits, multicastEndpoint);
//   await Future.delayed(Duration(seconds: 5));
//   await sender.send("Foo".codeUnits, multicastEndpoint);
//   await Future.delayed(Duration(seconds: 5));
//   await sender.send("Foo".codeUnits, multicastEndpoint);
//   await Future.delayed(Duration(seconds: 5));
//   await sender.send("Foo".codeUnits, multicastEndpoint);
//   await Future.delayed(Duration(seconds: 5));

//   // sender.close();
//   // receiver.close();
// }
