// GENERATED CODE - DO NOT MODIFY BY HAND

part of todo.common.models;

// **************************************************************************
// Generator: SerializerGenerator
// Target: class UserViewSerializer
// **************************************************************************

abstract class _$UserViewSerializer implements Serializer<UserView> {
  final TodoItemSerializer toTodoItemSerializer = new TodoItemSerializer();
  final TodoItemSerializer fromTodoItemSerializer = new TodoItemSerializer();

  Map toMap(UserView model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.id != null) {
        ret["id"] = model.id;
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
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  UserView fromMap(Map map, {UserView model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! UserView) {
      model = createModel();
    }
    model.id = map["id"];
    model.name = map["name"];
    model.tasks = map["tasks"]
        ?.map(
            (Map val) => fromTodoItemSerializer.fromMap(val, typeKey: typeKey))
        ?.toList();
    return model;
  }

  String modelString() => "UserView";
}

// **************************************************************************
// Generator: SerializerGenerator
// Target: class TodoItemSerializer
// **************************************************************************

abstract class _$TodoItemSerializer implements Serializer<TodoItem> {
  final DateTimeProcessor reminderDateTimeProcessor = const DateTimeProcessor();

  Map toMap(TodoItem model, {bool withType: false, String typeKey}) {
    Map ret = new Map();
    if (model != null) {
      if (model.id != null) {
        ret["id"] = model.id;
      }
      if (model.title != null) {
        ret["title"] = model.title;
      }
      if (model.message != null) {
        ret["message"] = model.message;
      }
      if (model.finished != null) {
        ret["finished"] = model.finished;
      }
      if (model.reminder != null) {
        ret["reminder"] = reminderDateTimeProcessor.serialize(model.reminder);
      }
      if (modelString() != null && withType) {
        ret[typeKey ?? defaultTypeInfoKey] = modelString();
      }
    }
    return ret;
  }

  TodoItem fromMap(Map map, {TodoItem model, String typeKey}) {
    if (map is! Map) {
      return null;
    }
    if (model is! TodoItem) {
      model = createModel();
    }
    model.id = map["id"];
    model.title = map["title"];
    model.message = map["message"];
    model.finished = map["finished"];
    model.reminder = reminderDateTimeProcessor.deserialize(map["reminder"]);
    return model;
  }

  String modelString() => "TodoItem";
}
