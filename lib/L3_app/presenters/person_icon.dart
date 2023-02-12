// Copyright (c) 2022. Alexandr Moroz

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../../L1_domain/entities/base_entity.dart';
import '../components/colors.dart';

class PersonIcon extends StatelessWidget {
  const PersonIcon(this.person, {required this.radius, this.borderSide});
  final Person person;
  final double radius;
  final BorderSide? borderSide;

  String get _hash => md5.convert(utf8.encode(person.email)).toString();

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: radius,
        backgroundColor: (borderSide?.color ?? greyColor).resolve(context),
        child: CircleAvatar(
          radius: radius - (borderSide?.width ?? 0.5) * 2,
          backgroundColor: lightGreyColor.resolve(context),
          backgroundImage: NetworkImage('https://www.gravatar.com/avatar/$_hash?s=${radius * 6}&d=identicon'),
        ),
      );
}
