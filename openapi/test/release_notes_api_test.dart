// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart';
import 'package:test/test.dart';

/// tests for ReleaseNotesApi
void main() {
  final instance = Openapi().getReleaseNotesApi();

  group(ReleaseNotesApi, () {
    // Release Notes
    //
    //Future<BuiltList<ReleaseNoteGet>> releaseNotes(String oldVersion) async
    test('test releaseNotes', () async {
      // TODO
    });
  });
}
