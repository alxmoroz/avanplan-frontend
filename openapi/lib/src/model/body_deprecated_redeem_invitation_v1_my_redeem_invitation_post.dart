//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_deprecated_redeem_invitation_v1_my_redeem_invitation_post.g.dart';

/// BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost
///
/// Properties:
/// * [invitationToken] 
@BuiltValue()
abstract class BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost implements Built<BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost, BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPostBuilder> {
  @BuiltValueField(wireName: r'invitation_token')
  String? get invitationToken;

  BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost._();

  factory BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost([void updates(BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPostBuilder b)]) = _$BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost> get serializer => _$BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPostSerializer();
}

class _$BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPostSerializer implements PrimitiveSerializer<BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost> {
  @override
  final Iterable<Type> types = const [BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost, _$BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost];

  @override
  final String wireName = r'BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.invitationToken != null) {
      yield r'invitation_token';
      yield serializers.serialize(
        object.invitationToken,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPostBuilder result,
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
  BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPostBuilder();
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

