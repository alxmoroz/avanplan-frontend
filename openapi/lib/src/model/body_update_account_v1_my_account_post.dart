//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_update_account_v1_my_account_post.g.dart';

/// BodyUpdateAccountV1MyAccountPost
///
/// Properties:
/// * [password] 
/// * [fullName] 
@BuiltValue()
abstract class BodyUpdateAccountV1MyAccountPost implements Built<BodyUpdateAccountV1MyAccountPost, BodyUpdateAccountV1MyAccountPostBuilder> {
  @BuiltValueField(wireName: r'password')
  String? get password;

  @BuiltValueField(wireName: r'full_name')
  String? get fullName;

  BodyUpdateAccountV1MyAccountPost._();

  factory BodyUpdateAccountV1MyAccountPost([void updates(BodyUpdateAccountV1MyAccountPostBuilder b)]) = _$BodyUpdateAccountV1MyAccountPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyUpdateAccountV1MyAccountPostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyUpdateAccountV1MyAccountPost> get serializer => _$BodyUpdateAccountV1MyAccountPostSerializer();
}

class _$BodyUpdateAccountV1MyAccountPostSerializer implements PrimitiveSerializer<BodyUpdateAccountV1MyAccountPost> {
  @override
  final Iterable<Type> types = const [BodyUpdateAccountV1MyAccountPost, _$BodyUpdateAccountV1MyAccountPost];

  @override
  final String wireName = r'BodyUpdateAccountV1MyAccountPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyUpdateAccountV1MyAccountPost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.password != null) {
      yield r'password';
      yield serializers.serialize(
        object.password,
        specifiedType: const FullType(String),
      );
    }
    if (object.fullName != null) {
      yield r'full_name';
      yield serializers.serialize(
        object.fullName,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyUpdateAccountV1MyAccountPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyUpdateAccountV1MyAccountPostBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'full_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fullName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyUpdateAccountV1MyAccountPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyUpdateAccountV1MyAccountPostBuilder();
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

