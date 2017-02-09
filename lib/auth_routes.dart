part of example.basic_auth.server;

class User implements UserModel {
  final String id;

  final String username;

  final String password;

  const User(this.id, this.username, this.password);

  String get authenticationId => username;

  String get authenticationKeyword => password;

  String get authorizationId => id;
}

const Map<String, User> kUsers = const {
  '0': const User('0', 'teja', 'word'),
  '1': const User('1', 'kleak', 'pass'),
};

const WhiteListPasswordChecker kModelManager =
    const WhiteListPasswordChecker(kUsers);

/// This route group contains login and logout routes
@RouteGroup()
@WrapSessionInterceptor(makeParams: const <Symbol, MakeParam>{
  #sessionManager: const MakeParamFromMethod(#sessionManager)
})
class AuthRoutes {
  @Post(path: '/login')
  @WrapBasicAuth(modelManager: kModelManager)
  void login(Request req) {}

  @Post(path: '/logout')
  void logout() {
    //TODO logout
  }

  CookieSessionManager sessionManager() => new CookieSessionManager();
}
