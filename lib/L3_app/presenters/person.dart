// Copyright (c) 2022. Alexandr Moroz

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../../L1_domain/entities/person.dart';
import '../../L1_domain/entities/role.dart';
import '../components/colors.dart';
import '../components/colors_base.dart';

class _PersonIcon extends StatelessWidget {
  const _PersonIcon(this.person, this.radius, {this.borderColor});
  final Person person;
  final double radius;
  final Color? borderColor;

  String get _hash => md5.convert(utf8.encode(person.email)).toString();

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: radius,
        backgroundColor: (borderColor ?? f3Color).resolve(context),
        child: CircleAvatar(
          radius: radius - 2,
          backgroundColor: b3Color.resolve(context),
          child: CircleAvatar(
            radius: radius - 3,
            backgroundColor: b2Color.resolve(context),
            backgroundImage: NetworkImage('https://www.gravatar.com/avatar/$_hash?s=${radius * 6}&d=identicon'),
          ),
        ),
      );
}

extension PersonPresenter on Person {
  String get rolesStr => roles.map((rCode) => Role(code: rCode, id: null).title).join(', ');
  Widget icon(double radius, {Color? borderColor}) => _PersonIcon(this, radius, borderColor: borderColor);
}
