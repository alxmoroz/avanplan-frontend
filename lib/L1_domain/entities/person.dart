//  Copyright (c) 2024. Alexandr Moroz

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import 'base_entity.dart';

abstract class Person extends RPersistable {
  Person({
    super.id,
    super.createdOn,
    super.updatedOn,
    required this.email,
    required this.fullName,
  });

  @protected
  final String fullName;
  final String email;

  String get emailMD5 => md5.convert(utf8.encode(email)).toString();

  String get viewableName => fullName.isNotEmpty ? fullName : email;

  @override
  String toString() => viewableName;
}
