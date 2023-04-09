//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_redeem_v1_registration_redeem_post.g.dart';

/// BodyRedeemV1RegistrationRedeemPost
///
/// Properties:
/// * [token] 
@BuiltValue()
abstract class BodyRedeemV1RegistrationRedeemPost implements Built<BodyRedeemV1RegistrationRedeemPost, BodyRedeemV1RegistrationRedeemPostBuilder> {
  @BuiltValueField(wireName: r'token')
  String get token;

  BodyRedeemV1RegistrationRedeemPost._();

  factory BodyRedeemV1RegistrationRedeemPost([void updates(BodyRedeemV1RegistrationRedeemPostBuilder b)]) = _$BodyRedeemV1RegistrationRedeemPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyRedeemV1RegistrationRedeemPostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyRedeemV1RegistrationRedeemPost> get serializer => _$BodyRedeemV1RegistrationRedeemPostSerializer();
}

class _$BodyRedeemV1RegistrationRedeemPostSerializer implements PrimitiveSerializer<BodyRedeemV1RegistrationRedeemPost> {
  @override
  final Iterable<Type> types = const [BodyRedeemV1RegistrationRedeemPost, _$BodyRedeemV1RegistrationRedeemPost];

  @override
  final String wireName = r'BodyRedeemV1RegistrationRedeemPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyRedeemV1RegistrationRedeemPost object, {
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
    BodyRedeemV1RegistrationRedeemPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyRedeemV1RegistrationRedeemPostBuilder result,
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
  BodyRedeemV1RegistrationRedeemPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyRedeemV1RegistrationRedeemPostBuilder();
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

