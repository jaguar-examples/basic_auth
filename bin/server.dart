library example.basic_auth.server;

import 'package:jaguar/jaguar.dart';
import 'package:jaguar_reflect/jaguar_reflect.dart';
import 'package:auth_basic/server.dart';

main() async {
  final api = new JaguarReflected(new LibraryApi());

  Configuration configuration = new Configuration();
  configuration.addApi(api);

  await serve(configuration);
}
