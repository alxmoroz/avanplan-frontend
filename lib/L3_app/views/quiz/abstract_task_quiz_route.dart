// Copyright (c) 2024. Alexandr Moroz

import 'package:go_router/go_router.dart';

import '../../extra/route.dart';
import '../../extra/router.dart';
import '../task/controllers/task_controller.dart';
import '../task/task_route.dart';

abstract class AbstractTaskQuizRoute extends MTRoute {
  AbstractTaskQuizRoute({required super.parent, required super.baseName, super.path, required super.builder});

  @override
  GoRouterRedirect? get redirect => (_, state) => state.extra is TaskController
      ? null
      : router.namedLocation(
          parent!.name,
          pathParameters: state.pathParameters,
        );

  @override
  String title(GoRouterState state) => '${(parent as BaseTaskRoute).title(state)} | ${(state.extra as TaskController).quizController!.stepTitle}';
}
