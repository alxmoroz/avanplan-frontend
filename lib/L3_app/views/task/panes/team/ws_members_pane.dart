// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'member_add_controller.dart';

class WSMembersPane extends StatelessWidget {
  const WSMembersPane(this.controller);
  final MemberAddController controller;

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => const Column(
          children: [],
        ),
      );
}
