import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for ReleaseNotesApi
void main() {
  final instance = Openapi().getReleaseNotesApi();

  group(ReleaseNotesApi, () {
    // Release Notes
    //
    //Future<BuiltList<ReleaseNoteGet>> releaseNotes(BodyReleaseNotes bodyReleaseNotes) async
    test('test releaseNotes', () async {
      // TODO
    });
  });
}
