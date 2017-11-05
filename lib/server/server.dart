library example.basic_auth.server;

import 'dart:async';

import 'package:jaguar/jaguar.dart';
import 'package:jaguar_auth/jaguar_auth.dart';
import 'package:jaguar_json/jaguar_json.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:ulid/ulid.dart';

import 'models.dart';

final List<User> users = <User>[];

class UserManager implements AuthModelManager<User> {
  const UserManager();

  User fetchByAuthenticationId(Context ctx, String email) =>
      users.firstWhere((User user) => user.email == email, orElse: () => null);

  User fetchByAuthorizationId(Context ctx, String id) =>
      users.firstWhere((User user) => user.id == id, orElse: () => null);

  User authenticate(Context ctx, String email, String keyword) {
    final User user = fetchByAuthenticationId(ctx, email);
    if (user == null) return null;
    if (!hasher.verify(user.password, keyword)) return null;
    return user;
  }

  static const Sha256Hasher hasher = const Sha256Hasher(
      'dfgsdg7897gdfghdsjk8324653k4hsdfshfg8hj34rf89&/&GJHKHHG');

  static const UserManager manager = const UserManager();
}

final JsonRepo jsonRepo = new JsonRepo(
    serializers: [new UserViewSerializer(), new TodoItemSerializer()]);

/// This route group contains login and logout routes
@Api()
class AuthRoutes extends Object with JsonRoutes {
  JsonRepo get repo => jsonRepo;

  @Post(path: '/login')
  @WrapOne(#basicAuth) // Wrap basic authenticator
  Response<String> login(Context ctx) {
    final User user = ctx.getInput<User>(BasicAuth);
    return toJson(user);
  }

  @Post(path: '/logout')
  Future logout(Context ctx) async {
    // Clear session data
    (await ctx.req.session).clear();
  }

  BasicAuth basicAuth(Context ctx) => new BasicAuth(UserManager.manager);
}

/// Collection of routes students can also access
@Api()
@WrapOne(#authorizer)
class TodoRoutes extends Object with JsonRoutes {
  JsonRepo get repo => jsonRepo;

  @Get()
  Response getAll(Context ctx) => toJson(ctx.getInput<User>(Authorizer).tasks);

  @Post()
  Future<Response> add(Context ctx) async {
    final TodoItem newItem = await fromJson(ctx, type: TodoItem);
    newItem.id = new Ulid().toUuid();
    final User user = ctx.getInput(Authorizer);
    user.tasks.add(newItem);
    return toJson(user.tasks);
  }

  @Delete(path: '/:id')
  Future<Response> deleteById(Context ctx) async {
    final String id = ctx.pathParams['id'];
    final User user = ctx.getInput(Authorizer);
    user.tasks.removeWhere((item) => item.id == id);
    return toJson(user.tasks);
  }

  Authorizer authorizer(Context ctx) => new Authorizer(UserManager.manager);
}

@Api(path: '/api')
class TodoApi {
  @IncludeApi(path: '/auth')
  final AuthRoutes auth = new AuthRoutes();

  @IncludeApi(path: '/todos')
  final TodoRoutes student = new TodoRoutes();
}
