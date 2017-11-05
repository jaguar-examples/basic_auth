// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/angular_components.dart';

import '../../services/services.dart';

@Component(
  selector: 'login-view',
  styleUrls: const ['login.css'],
  templateUrl: 'login.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, formDirectives],
  providers: const [materialProviders],
)
class LoginView {
  String email;

  String password;

  final Service service;

  LoginView(this.service);

  //TODO

  login() {
    // TODO show spinner
    service.login(email, password).then((_) {
      // TODO show message

      // TODO remove spinner
    }, onError: (_) {

    });
  }
}
