// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../login/login.dart';
import '../signup/signup.dart';

import '../../services/services.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    LoginView,
    SignupView
  ],
  providers: const [materialProviders, Service],
)
class AppComponent {
  final Service service;

  AppComponent(this.service);
}
