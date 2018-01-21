library example.basic_auth.server;

import 'dart:io';
import 'dart:async';

import 'package:jaguar/jaguar.dart';
import 'package:jaguar_auth/jaguar_auth.dart';
import 'package:jaguar_json/jaguar_json.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:ulid/ulid.dart';

import 'models.dart';

final List<User> users = <User>[
  new User.make(
    '1',
    'tejainece@gmail.com',
    UserManager.hasher.hash('1234as'),
    'Teja',
    <TodoItem>[],
  )
];

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

/// This route group contains login and logout routes
@Api()
class AuthRoutes extends Object with JsonRoutes {
  JsonRepo get repo => jsonRepo;

  @Post(path: '/login')
  Future<Response<String>> login(Context ctx) async {
    /// Authenticate using basic-auth. Throws 401 if authentication fails.
    final User user = await BasicAuth.authenticate(ctx, UserManager.manager);
    return toJson(user.toView);
  }

  @Post(path: '/signup')
  Future signup(Context ctx) async {
    final CreateUser creator = await fromJson(ctx, type: CreateUser);
    if (UserManager.manager.fetchByAuthenticationId(ctx, creator.email) !=
        null) {
      throw toJson({'@msg': 'Email already exists!'},
          statusCode: HttpStatus.BAD_REQUEST);
    }
    final User user = new User.make(new Ulid().toUuid(), creator.email,
        UserManager.hasher.hash(creator.password), creator.name, <TodoItem>[]);
    users.add(user);
    return toJson({'@msg': 'Signup successful!'});
  }

  @Post(path: '/logout')
  @WrapOne(#authorizer)
  Future logout(Context ctx) async {
    // Clear session data
    (await ctx.session).clear();
  }

  @Get(path: '/user')
  @WrapOne(#authorizer)
  Response getUser(Context ctx) =>
      toJson(ctx.getInterceptorResult<User>(Authorizer).toView);

  Authorizer authorizer(Context ctx) => new Authorizer(UserManager.manager);

  BasicAuth basicAuth(Context ctx) => new BasicAuth(UserManager.manager);
}

/// Collection of routes students can also access
@Api()
@WrapOne(#authorizer)
class TodoRoutes extends Object with JsonRoutes {
  JsonRepo get repo => jsonRepo;

  @Get()
  Response getAll(Context ctx) => toJson(ctx.getInterceptorResult<User>(Authorizer).tasks);

  @Post()
  Future<Response> add(Context ctx) async {
    final TodoItem newItem = await fromJson(ctx, type: TodoItem);
    newItem.id = new Ulid().toUuid();
    final User user = ctx.getInterceptorResult(Authorizer);
    user.tasks.add(newItem);
    return toJson(user.tasks);
  }

  @Delete(path: '/:id')
  Future<Response> deleteById(Context ctx) async {
    final String id = ctx.pathParams['id'];
    final User user = ctx.getInterceptorResult(Authorizer);
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
