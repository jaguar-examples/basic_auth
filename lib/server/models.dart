library todo.server.models;

import 'package:jaguar_common/jaguar_common.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

import '../common/models.dart';

export '../common/models.dart';

part 'models.g.dart';

class User implements AuthorizationUser {
  String id;

  String email;

  String password;

  String name;

  List<TodoItem> tasks;

  User() {
    tasks ??= <TodoItem>[];
  }

  User.make(this.id, this.email, this.password, this.name, this.tasks);

  String get authorizationId => id;

  UserView get toView => new UserView.make(id, name, tasks);
}

@GenSerializer(serializers: const [TodoItemSerializer])
class UserSerializer extends Serializer<User> with _$UserSerializer {
  @override
  User createModel() => new User();
}
