library example.basic_auth.client;

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:auth_header/auth_header.dart';

final HttpClient _client = new HttpClient();
final Map<String, Cookie> _cookies = {};

const String kHostname = 'localhost';

const int kPort = 8080;

Future<Null> printHttpClientResponse(HttpClientResponse resp) async {
  StringBuffer contents = new StringBuffer();
  await for (String data in resp.transform(UTF8.decoder)) {
    contents.write(data);
  }

  print('=========================');
  print("body:");
  print(contents.toString());
  print("statusCode:");
  print(resp.statusCode);
  print("headers:");
  print(resp.headers);
  print("cookies:");
  print(resp.cookies);
  print('=========================');
}

getOne() async {
  HttpClientRequest req = await _client.get(kHostname, kPort, '/api/book/0');
  req.cookies.addAll(_cookies.values);
  HttpClientResponse resp = await req.close();

  for (Cookie cook in resp.cookies) {
    _cookies[cook.name] = cook;
  }

  await printHttpClientResponse(resp);
}

getAll() async {
  HttpClientRequest req = await _client.get(kHostname, kPort, '/api/book/all');
  req.cookies.addAll(_cookies.values);
  HttpClientResponse resp = await req.close();

  for (Cookie cook in resp.cookies) {
    _cookies[cook.name] = cook;
  }

  await printHttpClientResponse(resp);
}

login() async {
  HttpClientRequest req = await _client.post(kHostname, kPort, '/api/login');
  req.cookies.addAll(_cookies.values);

  AuthHeaders auth = new AuthHeaders();
  String credentials =
      const Base64Codec.urlSafe().encode('teja:word'.codeUnits);
  auth.addItem(new AuthHeaderItem('Basic', credentials));

  req.headers.add(HttpHeaders.AUTHORIZATION, auth.toString());
  HttpClientResponse resp = await req.close();

  for (Cookie cook in resp.cookies) {
    _cookies[cook.name] = cook;
  }

  await printHttpClientResponse(resp);
}

main() async {
  // Must return 401 Unauthorized
  await getOne();
  await getAll();

  // Lets login
  await login();

  // Now the routes must return data
  await getOne();
  await getAll();
  exit(0);
}
