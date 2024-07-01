// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/user.dart';
import '../components/avatar.dart';

extension UserPresenter on User {
  Widget icon(double radius, {Color? borderColor}) => MTAvatar(
        radius,
        borderColor: borderColor,
        user: this,
      );
}
