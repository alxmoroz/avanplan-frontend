import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for RegistrationApi
void main() {
  final instance = Openapi().getRegistrationApi();

  group(RegistrationApi, () {
    // Create
    //
    //Future<bool> createV1RegistrationCreatePost(BodyCreateV1RegistrationCreatePost bodyCreateV1RegistrationCreatePost) async
    test('test createV1RegistrationCreatePost', () async {
      // TODO
    });

    // Redeem
    //
    //Future<Token> redeemV1RegistrationRedeemPost(BodyRedeemV1RegistrationRedeemPost bodyRedeemV1RegistrationRedeemPost) async
    test('test redeemV1RegistrationRedeemPost', () async {
      // TODO
    });
  });
}
