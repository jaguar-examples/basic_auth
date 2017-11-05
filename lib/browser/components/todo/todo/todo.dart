// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/angular_components.dart';
import '../../../../common/models.dart';

import '../../../services/services.dart';

@Component(
  selector: 'todos-view',
  styleUrls: const ['todo.css'],
  templateUrl: 'todo.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, formDirectives],
  providers: const [materialProviders],
)
class TodosView {
  final TodoItem newTask = new TodoItem();

  final Service service;

  final List<TodoItem> tasks = <TodoItem>[];

  TodosView(this.service);

  //TODO

  add() {
    // TODO show spinner
    service.addTask(newTask).then((List<TodoItem> latestTasks) {
      // TODO show message

      tasks.clear();
      tasks.addAll(latestTasks);

      // TODO remove spinner
    }, onError: (_) {
      // TODO
    });
  }
}
