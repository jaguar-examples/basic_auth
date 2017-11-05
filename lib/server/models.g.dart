// GENERATED CODE - DO NOT MODIFY BY HAND

part of todo.server.models;

// **************************************************************************
// Generator: SerializerGenerator
// Target: class UserSerializer
// **************************************************************************

abstract class _$UserSerializer implements Serializer<User> {
  final TodoItemSerializer toTodoItemSerializer = new TodoItemSerializer();
  final TodoItemSerializer fromTodoItemSerializer = new TodoItemSerializer();

  Map toMap(User model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.id != null) {
        ret["id"] = model.id;
      }
      if (model.email != null) {
        ret["email"] = model.email;
      }
      if (model.password != null) {
        ret["password"] = model.password;
      }
      if (model.name != null) {
        ret["name"] = model.name;
      }
      if (model.tasks != null) {
        ret["tasks"] = model.tasks
            ?.map((TodoItem val) => val != null
                ? toTodoItemSerializer.toMap(val,
                    withType: withType, typeKey: typeKey)
                : null)
            ?.toList();
      }
      if (model.authorizationId != null) {
        ret["authorizationId"] = model.authorizationId;
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  User fromMap(Map map, {User model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! User) {
      model = createModel();
    }
    model.id = map["id"];
    model.email = map["email"];
    model.password = map["password"];
    model.name = map["name"];
    model.tasks = map["tasks"]
        ?.map(
            (Map val) => fromTodoItemSerializer.fromMap(val, typeKey: typeKey))
        ?.toList();
    return model;
  }

  String modelString() => "User";
}
