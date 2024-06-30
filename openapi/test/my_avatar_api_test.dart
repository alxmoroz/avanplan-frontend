import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyAvatarApi
void main() {
  final instance = Openapi().getMyAvatarApi();

  group(MyAvatarApi, () {
    // Delete Avatar
    //
    //Future<bool> deleteAvatarV1MyAvatarDelete() async
    test('test deleteAvatarV1MyAvatarDelete', () async {
      // TODO
    });

    // Upload Avatar
    //
    //Future<String> uploadAvatar(MultipartFile file) async
    test('test uploadAvatar', () async {
      // TODO
    });
  });
}
