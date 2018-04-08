library models;

import 'package:jaguar_common/jaguar_common.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:jaguar_serializer_mongo/jaguar_serializer_mongo.dart';

import 'package:common/common.dart';

export 'package:common/common.dart';

part 'models.g.dart';

class User implements AuthorizationUser {
  String id;

  String email;

  String password;

  String name;

  List<Task> tasks;

  User() {
    tasks ??= <Task>[];
  }

  User.make(this.id, this.email, this.password, this.name, this.tasks);

  String get authorizationId => id;

  UserView toView() => new UserView(id: id, name: name, tasks: tasks);
}

@GenSerializer(
  serializers: const [TaskSerializer],
  fields: {'id': EnDecode(alias: '_id', processor: MongoId())},
)
class UserSerializer extends Serializer<User> with _$UserSerializer {
  @override
  User createModel() => new User();
}
