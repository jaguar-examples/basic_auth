library example.basic_auth.server;

import 'package:jaguar/jaguar.dart';
import 'package:auth_basic/server/server.dart';

main() async {
  final server = new Jaguar(port: 10000);
  server.addApiReflected(new TodoApi());

  server.log.onRecord.listen((r) => print(r));

  await server.serve();
}
