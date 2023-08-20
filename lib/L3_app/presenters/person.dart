// Copyright (c) 2022. Alexandr Moroz

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../../L1_domain/entities/person.dart';
import '../components/colors.dart';
import 'role.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar(this.person, this.radius, {this.borderSide});
  final Person person;
  final double radius;
  final BorderSide? borderSide;

  String get _hash => md5.convert(utf8.encode(person.email)).toString();

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: radius,
        backgroundColor: (borderSide?.color ?? lightGreyColor).resolve(context),
        child: CircleAvatar(
          radius: radius - (borderSide?.width ?? 0.5) * 2,
          backgroundColor: darkBackgroundColor.resolve(context),
          backgroundImage: NetworkImage('https://www.gravatar.com/avatar/$_hash?s=${radius * 6}&d=identicon'),
        ),
      );
}

extension PersonPresenter on Person {
  String get rolesStr => roles.map((rCode) => localizedRoleCode(rCode)).join(', ');
  Widget icon(double radius, {BorderSide? borderSide}) => PersonAvatar(this, radius, borderSide: borderSide);
}
