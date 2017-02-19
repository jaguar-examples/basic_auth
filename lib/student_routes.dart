part of example.basic_auth.server;

/// Collection of routes students can also access
@RouteGroup()
@Wrap(const [#sessionInterceptor])
@WrapUserAuthoriser(kModelManager)
class StudentRoutes {
  @Get(path: '/all')
  Response<String> getAllBooks() {
    List<Map> ret = _books.values.map((Book book) => book.toMap()).toList();

    Response<String> resp = new Response<String>(JSON.encode(ret));
    resp.cookies.add(new Cookie('sample-cookie', 'sample-cookie-value'));
    return resp;
  }

  @Get(path: '/:id', headers: const {'sample-header': 'sample-value'})
  String getBook(String id) {
    Book book = _books[id];
    return book.toJson();
  }

  WrapSessionInterceptor sessionInterceptor() =>
      new WrapSessionInterceptor(sessionManager());

  CookieSessionManager sessionManager() => new CookieSessionManager();
}
