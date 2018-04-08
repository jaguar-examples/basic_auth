// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$UserSerializer implements Serializer<User> {
  final _taskSerializer = new TaskSerializer();

  Map<String, dynamic> toMap(User model,
      {bool withType: false, String typeKey}) {
    Map<String, dynamic> ret;
    if (model != null) {
      ret = <String, dynamic>{};
      setNullableValue(ret, "id", model.id);
      setNullableValue(ret, "email", model.email);
      setNullableValue(ret, "password", model.password);
      setNullableValue(ret, "name", model.name);
      setNullableValue(
          ret,
          "tasks",
          nullableIterableMapper(
              model.tasks,
              (val) => _taskSerializer.toMap(val as Task,
                  withType: withType, typeKey: typeKey)));
      setNullableValue(ret, "authorizationId", model.authorizationId);
      setTypeKeyValue(typeKey, modelString(), withType, ret);
    }
    return ret;
  }

  User fromMap(Map<String, dynamic> map, {User model, String typeKey}) {
    if (map == null) {
      return null;
    }
    if (model is! User) {
      model = new User();
    }
    model.id = map["id"] as String;
    model.email = map["email"] as String;
    model.password = map["password"] as String;
    model.name = map["name"] as String;
    model.tasks = nullableIterableMapper<Task>(
        map["tasks"] as Iterable,
        (val) => _taskSerializer.fromMap(val as Map<String, dynamic>,
            typeKey: typeKey));
    return model;
  }

  String modelString() => "User";
}
