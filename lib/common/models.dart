library todo.common.models;

import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'models.g.dart';

class CreateUser {
  String name;

  String email;

  String password;
}

class UserView {
  String id;

  String name;

  List<TodoItem> tasks;

  UserView();

  UserView.make(this.id, this.name, this.tasks);
}

/// Model for a task
class TodoItem {
  /// Id of the task
  String id;

  /// Title of the task
  String title;

  /// Message for the task
  String message;

  /// Has the task been completed?
  bool finished = false;

  /// Reminder
  DateTime reminder;

  TodoItem();

  TodoItem.make(this.id, this.title, this.message,
      {this.reminder, this.finished: false});

  String toString() {
    final sb = new StringBuffer();

    sb.writeln('Title: $title');
    sb.writeln('Finished: $finished');
    sb.writeln(message);
    // TODO reminder

    return sb.toString();
  }
}

class DateTimeProcessor implements FieldProcessor<DateTime, int> {
  const DateTimeProcessor();

  DateTime deserialize(int value) => value != null
      ? new DateTime.fromMillisecondsSinceEpoch(value * 1000, isUtc: true)
      : null;

  int serialize(DateTime value) =>
      value != null ? value.millisecondsSinceEpoch ~/ 1000 : null;
}

@GenSerializer()
class CreateUserSerializer extends Serializer<CreateUser>
    with _$CreateUserSerializer {
  @override
  CreateUser createModel() => new CreateUser();
}

@GenSerializer(serializers: const [TodoItemSerializer])
class UserViewSerializer extends Serializer<UserView>
    with _$UserViewSerializer {
  @override
  UserView createModel() => new UserView();
}

@GenSerializer(fields: const {
  'reminder': const EnDecode(processor: const DateTimeProcessor())
})
class TodoItemSerializer extends Serializer<TodoItem>
    with _$TodoItemSerializer {
  @override
  TodoItem createModel() => new TodoItem();
}

final JsonRepo jsonRepo = new JsonRepo(serializers: [
  new UserViewSerializer(),
  new TodoItemSerializer(),
  new CreateUserSerializer()
]);
