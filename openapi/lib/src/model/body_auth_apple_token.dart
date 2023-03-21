//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_auth_apple_token.g.dart';

/// BodyAuthAppleToken
///
/// Properties:
/// * [token] 
/// * [platform] 
/// * [locale] 
/// * [name] 
/// * [email] 
/// * [invited] 
@BuiltValue()
abstract class BodyAuthAppleToken implements Built<BodyAuthAppleToken, BodyAuthAppleTokenBuilder> {
  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'platform')
  String get platform;

  @BuiltValueField(wireName: r'locale')
  String get locale;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'invited')
  bool? get invited;

  BodyAuthAppleToken._();

  factory BodyAuthAppleToken([void updates(BodyAuthAppleTokenBuilder b)]) = _$BodyAuthAppleToken;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyAuthAppleTokenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyAuthAppleToken> get serializer => _$BodyAuthAppleTokenSerializer();
}

class _$BodyAuthAppleTokenSerializer implements PrimitiveSerializer<BodyAuthAppleToken> {
  @override
  final Iterable<Type> types = const [BodyAuthAppleToken, _$BodyAuthAppleToken];

  @override
  final String wireName = r'BodyAuthAppleToken';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyAuthAppleToken object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'platform';
    yield serializers.serialize(
      object.platform,
      specifiedType: const FullType(String),
    );
    yield r'locale';
    yield serializers.serialize(
      object.locale,
      specifiedType: const FullType(String),
    );
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
    if (object.invited != null) {
      yield r'invited';
      yield serializers.serialize(
        object.invited,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyAuthAppleToken object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyAuthAppleTokenBuilder result,
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
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.platform = valueDes;
          break;
        case r'locale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.locale = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'invited':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.invited = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyAuthAppleToken deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyAuthAppleTokenBuilder();
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

