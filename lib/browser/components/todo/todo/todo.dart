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

  final UIService uiService;

  TodosView(this.service, this.uiService);

  add() {
    // Show spinner
    final int overlayId = uiService.showOverlay(
        new SpinnerInfo(title: 'Please wait ...', message: 'Adding new task.'));

    service.addTask(newTask).then((_) {
      // TODO show message

      // Remove spinner
      uiService.hideOverlay(overlayId);
    }, onError: (_) {
      // TODO show message

      // Remove spinner
      uiService.hideOverlay(overlayId);
    });
  }

  remove(TodoItem item) {
    // Show spinner
    final int overlayId = uiService.showOverlay(
        new SpinnerInfo(title: 'Please wait ...', message: 'Removing task.'));

    service.removeTask(item).then((_) {
      // TODO show message

      // Remove spinner
      uiService.hideOverlay(overlayId);
    }, onError: (_) {
      // TODO show message

      // Remove spinner
      uiService.hideOverlay(overlayId);
    });
  }
}
