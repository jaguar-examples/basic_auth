// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/angular_components.dart';

import '../../../common/models.dart';
import '../../services/services.dart';

@Component(
  selector: 'signup-view',
  styleUrls: const ['signup.css'],
  templateUrl: 'signup.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, formDirectives],
  providers: const [materialProviders],
)
class SignupView {
  final CreateUser creator = new CreateUser();

  final Service service;

  SignupView(this.service);

  signup() {
    // TODO show spinner
    service.signup(creator).then((_) {
      // TODO show message

      // TODO remove spinner
    }, onError: (_) {

    });
  }
}
