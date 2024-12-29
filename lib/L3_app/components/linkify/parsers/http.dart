// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../../navigation/route.dart';
import '../../../navigation/router.dart';
import '../../../views/app/services.dart';
import '../../../views/task/task_route.dart';
import '../element.dart';
import '../parser.dart';

class HttpElement extends UriElement {
  static final _dupSlashes = RegExp(r'/{2,}');

  HttpElement(super.text) {
    if (hasUri) {
      // нормализация uri
      if (!uri!.hasScheme) uri = Uri.parse('https://$text');
      uri = uri!.replace(path: uri!.path.replaceAll(_dupSlashes, '/'));

      final u = uri!;
      if (u.isInner && !u.hasEmptyPath) {
        final rml = router.configuration.findMatch(u);
        final matchRoute = rml.matches.lastOrNull;
        final r = matchRoute?.route as MTRoute?;
        // есть такой маршрут
        if (r != null) {
          final state = matchRoute!.buildState(router.configuration, rml);
          // Задача, проект, цель, бэклог и т.п
          if (r is BaseTaskRoute) {
            // инициализация контроллера в маршруте
            if (r.redirect != null) r.redirect!(globalContext, state);
            final td = r.td;
            // название задачи, если есть. Иначе название экрана по умолчанию (Задача #XXX)
            text = tasksMainController.task(td.wsId, td.id)?.title ?? r.title(state);
          }
          // Экраны внутри Аванплана
          else {
            text = r.title(state);
          }
        }
      } else {
        final longPath = u.pathSegments.length > 2 || u.hasQuery;
        final path = u.pathSegments.take(3).join('/');
        text = '${u.host}${path.isNotEmpty ? '/' : ''}$path${longPath ? '...' : ''}';
      }
    }
  }

  @override
  String toString() => text;
}

class HttpParser extends UriParser {
  const HttpParser();

  static final _urlRe = RegExp(
    r'^(.*?)((?:https?://)?(?:[-\w0-9_]{2,63}\.){1,3}\w{2,61}(?::\d{1,5})?(?:[/#?](?:[^\x00-\x7F]|[\w-0-9@:%_+.~&?/=])*)?)',
    caseSensitive: false,
    dotAll: true,
  );

  @override
  RegExp get re => _urlRe;

  @override
  SpanElement matchedElement(String text) => HttpElement(text);
}
