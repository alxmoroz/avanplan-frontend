import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

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
