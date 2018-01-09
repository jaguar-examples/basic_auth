// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../login/login.dart';
import '../signup/signup.dart';
import '../todo/todo/todo.dart';

import '../../services/services.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    LoginView,
    SignupView,
    TodosView,
  ],
  providers: const [materialProviders, Service, UIService],
)
class AppComponent {
  final Service service;

  final UIService uiService;

  bool showUserDD = false;

  AppComponent(this.service, this.uiService) {
    // TODO show spinner
    service.fetchUser().then((_) {
      // TODO hide spinner
    }, onError: (_) {
      // TODO hide spinner
    });

    document.body.onMouseDown.listen((_) {
      //showUserDD = false;
    });
  }

  logout() {
    service.logout().then((_) {
      // TODO
    }, onError: (_) {
      // TODO
    });
  }
}
