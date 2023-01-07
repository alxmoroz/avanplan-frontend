//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_update_push_token_v1_my_push_token_post.g.dart';

/// BodyUpdatePushTokenV1MyPushTokenPost
///
/// Properties:
/// * [code] 
/// * [platform] 
/// * [hasPermission] 
@BuiltValue()
abstract class BodyUpdatePushTokenV1MyPushTokenPost implements Built<BodyUpdatePushTokenV1MyPushTokenPost, BodyUpdatePushTokenV1MyPushTokenPostBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'platform')
  String get platform;

  @BuiltValueField(wireName: r'has_permission')
  bool get hasPermission;

  BodyUpdatePushTokenV1MyPushTokenPost._();

  factory BodyUpdatePushTokenV1MyPushTokenPost([void updates(BodyUpdatePushTokenV1MyPushTokenPostBuilder b)]) = _$BodyUpdatePushTokenV1MyPushTokenPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyUpdatePushTokenV1MyPushTokenPostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyUpdatePushTokenV1MyPushTokenPost> get serializer => _$BodyUpdatePushTokenV1MyPushTokenPostSerializer();
}

class _$BodyUpdatePushTokenV1MyPushTokenPostSerializer implements PrimitiveSerializer<BodyUpdatePushTokenV1MyPushTokenPost> {
  @override
  final Iterable<Type> types = const [BodyUpdatePushTokenV1MyPushTokenPost, _$BodyUpdatePushTokenV1MyPushTokenPost];

  @override
  final String wireName = r'BodyUpdatePushTokenV1MyPushTokenPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyUpdatePushTokenV1MyPushTokenPost object, {
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
    BodyUpdatePushTokenV1MyPushTokenPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyUpdatePushTokenV1MyPushTokenPostBuilder result,
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
  BodyUpdatePushTokenV1MyPushTokenPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyUpdatePushTokenV1MyPushTokenPostBuilder();
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

