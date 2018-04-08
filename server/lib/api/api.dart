library example.basic_auth.server;

import 'dart:io';
import 'dart:async';

import 'package:jaguar/jaguar.dart';
import 'package:jaguar_auth/jaguar_auth.dart';
import 'package:ulid/ulid.dart';

import 'package:server/models/models.dart';

final List<User> users = <User>[
  new User.make(
    '1',
    'tejainece@gmail.com',
    UserManager.hasher.hash('1234as'),
    'Teja',
    <Task>[],
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
class AuthRoutes {
  @PostJson(path: '/login')
  Future<UserView> login(Context ctx) async {
    /// Authenticate using basic-auth. Throws 401 if authentication fails.
    final User user = await JsonAuth.authenticate(ctx, UserManager.manager);
    return user.toView();
  }

  @PostJson(path: '/signup')
  Future signup(Context ctx) async {
    final CreateUser creator =
        await ctx.req.bodyAsJson(convert: CreateUser.fromJson);
    if (UserManager.manager.fetchByAuthenticationId(ctx, creator.email) !=
        null) {
      throw Response.json({'@msg': 'Email already exists!'},
          statusCode: HttpStatus.BAD_REQUEST);
    }
    final User user = new User.make(new Ulid().toUuid(), creator.email,
        UserManager.hasher.hash(creator.password), creator.name, <Task>[]);
    users.add(user);
    return {'@msg': 'Signup successful!'};
  }

  @Post(path: '/logout')
  @WrapOne(#authorizer)
  Future logout(Context ctx) async {
    // Clear session data
    (await ctx.session).clear();
  }

  @GetJson(path: '/user')
  @WrapOne(#authorizer)
  Future<UserView> getUser(Context ctx) async {
    User user = await Authorizer.authorize(ctx, UserManager.manager);
    return user.toView();
  }
}

/// Collection of routes students can also access
@Api()
@WrapOne(#authorizer)
class TodoRoutes {

  @GetJson()
  Future<List<Task>> getAll(Context ctx) async {
    User user = await Authorizer.authorize(ctx, UserManager.manager);
    return user.tasks;
  }

  @PostJson()
  Future<List<Task>> add(Context ctx) async {
    User user = await Authorizer.authorize(ctx, UserManager.manager);
    final Task newTask = await ctx.req.bodyAsJson(convert: Task.fromMap);
    newTask.id = new Ulid().toUuid();
    user.tasks.add(newTask);
    return user.tasks;
  }

  @DeleteJson(path: '/:id')
  Future<List<Task>> deleteById(Context ctx) async {
    User user = await Authorizer.authorize(ctx, UserManager.manager);
    final String id = ctx.pathParams['id'];
    user.tasks.removeWhere((item) => item.id == id);
    return user.tasks;
  }
}

@Api(path: '/api')
class TasksApi {
  @IncludeApi(path: '/auth')
  final AuthRoutes auth = new AuthRoutes();

  @IncludeApi(path: '/tasks')
  final TodoRoutes student = new TodoRoutes();
}
