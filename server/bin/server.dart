library example.basic_auth.server;

import 'package:jaguar/jaguar.dart';
import 'package:jaguar_reflect/jaguar_reflect.dart';
import 'package:jaguar_dev_proxy/jaguar_dev_proxy.dart';
import 'package:server/api/api.dart';

main() async {
  final server = new Jaguar(port: 10002);
  server.addApi(reflect(new TasksApi()));
  server.addApi(new PrefixedProxyServer('', 'http://localhost:10001/'));

  server.log.onRecord.listen((r) => print(r));

  await server.serve();
}
