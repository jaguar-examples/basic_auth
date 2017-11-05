library login_client.services;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:http/browser_client.dart' as http;
import 'package:jaguar_client/jaguar_client.dart';

import '../../common/models.dart';

@Injectable()
class Service {
  final JsonClient jClient;

  Service()
      : jClient = new JsonClient(new http.BrowserClient(), repo: jsonRepo);

  UserView _user;

  UserView get user => _user;

  List<TodoItem> get tasks => user?.tasks;

  Future<Null> login(String email, String password) async {
    final payload = new AuthPayload(email, password);
    final JsonResponse resp =
        await jClient.authenticateBasic(payload, url: '/api/auth/login');
    if (resp.statusCode != 200) {
      throw new Exception("Login failed!");
    }
    _user = resp.deserialize(type: UserView);
  }

  Future<Null> signup(CreateUser user) async {
    final JsonResponse resp =
        await jClient.post('/api/auth/signup', body: user);
    if (resp.statusCode != 200) {
      throw new Exception("Signup failed!");
    }
  }

  Future<Null> logout() async {
    final JsonResponse resp = await jClient.post('/api/auth/logout');
    if (resp.statusCode != 200) {
      throw new Exception("Logout failed!");
    }
    _user = null;
  }
}
