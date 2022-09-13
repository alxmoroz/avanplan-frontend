//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_update_my_account_v1_my_account_put.g.dart';

/// BodyUpdateMyAccountV1MyAccountPut
///
/// Properties:
/// * [password] 
/// * [fullName] 
@BuiltValue()
abstract class BodyUpdateMyAccountV1MyAccountPut implements Built<BodyUpdateMyAccountV1MyAccountPut, BodyUpdateMyAccountV1MyAccountPutBuilder> {
  @BuiltValueField(wireName: r'password')
  String? get password;

  @BuiltValueField(wireName: r'full_name')
  String? get fullName;

  BodyUpdateMyAccountV1MyAccountPut._();

  factory BodyUpdateMyAccountV1MyAccountPut([void updates(BodyUpdateMyAccountV1MyAccountPutBuilder b)]) = _$BodyUpdateMyAccountV1MyAccountPut;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyUpdateMyAccountV1MyAccountPutBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyUpdateMyAccountV1MyAccountPut> get serializer => _$BodyUpdateMyAccountV1MyAccountPutSerializer();
}

class _$BodyUpdateMyAccountV1MyAccountPutSerializer implements PrimitiveSerializer<BodyUpdateMyAccountV1MyAccountPut> {
  @override
  final Iterable<Type> types = const [BodyUpdateMyAccountV1MyAccountPut, _$BodyUpdateMyAccountV1MyAccountPut];

  @override
  final String wireName = r'BodyUpdateMyAccountV1MyAccountPut';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyUpdateMyAccountV1MyAccountPut object, {
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
    BodyUpdateMyAccountV1MyAccountPut object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyUpdateMyAccountV1MyAccountPutBuilder result,
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
  BodyUpdateMyAccountV1MyAccountPut deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyUpdateMyAccountV1MyAccountPutBuilder();
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

