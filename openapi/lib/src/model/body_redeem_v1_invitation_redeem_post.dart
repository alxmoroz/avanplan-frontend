//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_redeem_v1_invitation_redeem_post.g.dart';

/// BodyRedeemV1InvitationRedeemPost
///
/// Properties:
/// * [token] 
@BuiltValue()
abstract class BodyRedeemV1InvitationRedeemPost implements Built<BodyRedeemV1InvitationRedeemPost, BodyRedeemV1InvitationRedeemPostBuilder> {
  @BuiltValueField(wireName: r'token')
  String get token;

  BodyRedeemV1InvitationRedeemPost._();

  factory BodyRedeemV1InvitationRedeemPost([void updates(BodyRedeemV1InvitationRedeemPostBuilder b)]) = _$BodyRedeemV1InvitationRedeemPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyRedeemV1InvitationRedeemPostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyRedeemV1InvitationRedeemPost> get serializer => _$BodyRedeemV1InvitationRedeemPostSerializer();
}

class _$BodyRedeemV1InvitationRedeemPostSerializer implements PrimitiveSerializer<BodyRedeemV1InvitationRedeemPost> {
  @override
  final Iterable<Type> types = const [BodyRedeemV1InvitationRedeemPost, _$BodyRedeemV1InvitationRedeemPost];

  @override
  final String wireName = r'BodyRedeemV1InvitationRedeemPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyRedeemV1InvitationRedeemPost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyRedeemV1InvitationRedeemPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyRedeemV1InvitationRedeemPostBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyRedeemV1InvitationRedeemPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyRedeemV1InvitationRedeemPostBuilder();
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

