//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_update_push_token_v1_my_push_tokens_update_post.g.dart';

/// BodyUpdatePushTokenV1MyPushTokensUpdatePost
///
/// Properties:
/// * [code] 
/// * [platform] 
/// * [hasPermission] 
@BuiltValue()
abstract class BodyUpdatePushTokenV1MyPushTokensUpdatePost implements Built<BodyUpdatePushTokenV1MyPushTokensUpdatePost, BodyUpdatePushTokenV1MyPushTokensUpdatePostBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'platform')
  String get platform;

  @BuiltValueField(wireName: r'has_permission')
  bool get hasPermission;

  BodyUpdatePushTokenV1MyPushTokensUpdatePost._();

  factory BodyUpdatePushTokenV1MyPushTokensUpdatePost([void updates(BodyUpdatePushTokenV1MyPushTokensUpdatePostBuilder b)]) = _$BodyUpdatePushTokenV1MyPushTokensUpdatePost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyUpdatePushTokenV1MyPushTokensUpdatePostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyUpdatePushTokenV1MyPushTokensUpdatePost> get serializer => _$BodyUpdatePushTokenV1MyPushTokensUpdatePostSerializer();
}

class _$BodyUpdatePushTokenV1MyPushTokensUpdatePostSerializer implements PrimitiveSerializer<BodyUpdatePushTokenV1MyPushTokensUpdatePost> {
  @override
  final Iterable<Type> types = const [BodyUpdatePushTokenV1MyPushTokensUpdatePost, _$BodyUpdatePushTokenV1MyPushTokensUpdatePost];

  @override
  final String wireName = r'BodyUpdatePushTokenV1MyPushTokensUpdatePost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyUpdatePushTokenV1MyPushTokensUpdatePost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'platform';
    yield serializers.serialize(
      object.platform,
      specifiedType: const FullType(String),
    );
    yield r'has_permission';
    yield serializers.serialize(
      object.hasPermission,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyUpdatePushTokenV1MyPushTokensUpdatePost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyUpdatePushTokenV1MyPushTokensUpdatePostBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.platform = valueDes;
          break;
        case r'has_permission':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasPermission = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyUpdatePushTokenV1MyPushTokensUpdatePost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyUpdatePushTokenV1MyPushTokensUpdatePostBuilder();
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

