// Copyright (c) 2024. Alexandr Moroz

import 'package:go_router/go_router.dart';

import '../../navigation/route.dart';
import '../../navigation/router.dart';
import '../task/task_route.dart';
import 'abstract_task_quiz_controller.dart';

abstract class AbstractTaskQuizRoute extends MTRoute {
  AbstractTaskQuizRoute({required super.parent, required super.baseName, super.path, required super.builder});

  @override
  GoRouterRedirect? get redirect => (_, state) => state.extra is AbstractTaskQuizController
      ? null
      : router.namedLocation(
          parent!.name,
          pathParameters: state.pathParameters,
        );

  @override
  String title(GoRouterState state) => '${(parent as BaseTaskRoute).title(state)} | ${(state.extra as AbstractTaskQuizController).stepTitle}';
}
