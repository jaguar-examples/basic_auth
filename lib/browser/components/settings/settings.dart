// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/core.dart';
import 'package:angular_components/angular_components.dart';

/// User model
class User {
  /// ID for the user in the database
  String id;

  /// User name
  String name;

  /// User's email
  String email;

  String password;

  String dateOfBirth;

  String bio;
}

@Component(
  selector: 'signup-view',
  styleUrls: const ['settings.css'],
  templateUrl: 'settings.html',
  directives: const [materialDirectives],
  providers: const [materialProviders],
)
class SignupView {
  User user;
}
