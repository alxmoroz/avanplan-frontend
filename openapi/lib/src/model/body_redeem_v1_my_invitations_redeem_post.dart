//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_redeem_v1_my_invitations_redeem_post.g.dart';

/// BodyRedeemV1MyInvitationsRedeemPost
///
/// Properties:
/// * [invitationToken] 
@BuiltValue()
abstract class BodyRedeemV1MyInvitationsRedeemPost implements Built<BodyRedeemV1MyInvitationsRedeemPost, BodyRedeemV1MyInvitationsRedeemPostBuilder> {
  @BuiltValueField(wireName: r'invitation_token')
  String get invitationToken;

  BodyRedeemV1MyInvitationsRedeemPost._();

  factory BodyRedeemV1MyInvitationsRedeemPost([void updates(BodyRedeemV1MyInvitationsRedeemPostBuilder b)]) = _$BodyRedeemV1MyInvitationsRedeemPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyRedeemV1MyInvitationsRedeemPostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyRedeemV1MyInvitationsRedeemPost> get serializer => _$BodyRedeemV1MyInvitationsRedeemPostSerializer();
}

class _$BodyRedeemV1MyInvitationsRedeemPostSerializer implements PrimitiveSerializer<BodyRedeemV1MyInvitationsRedeemPost> {
  @override
  final Iterable<Type> types = const [BodyRedeemV1MyInvitationsRedeemPost, _$BodyRedeemV1MyInvitationsRedeemPost];

  @override
  final String wireName = r'BodyRedeemV1MyInvitationsRedeemPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyRedeemV1MyInvitationsRedeemPost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'invitation_token';
    yield serializers.serialize(
      object.invitationToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyRedeemV1MyInvitationsRedeemPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyRedeemV1MyInvitationsRedeemPostBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'invitation_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.invitationToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyRedeemV1MyInvitationsRedeemPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyRedeemV1MyInvitationsRedeemPostBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

