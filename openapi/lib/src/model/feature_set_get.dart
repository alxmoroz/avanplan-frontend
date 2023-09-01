//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'feature_set_get.g.dart';

/// FeatureSetGet
///
/// Properties:
/// * [id] 
/// * [code] 
@BuiltValue()
abstract class FeatureSetGet implements Built<FeatureSetGet, FeatureSetGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  FeatureSetGet._();

  factory FeatureSetGet([void updates(FeatureSetGetBuilder b)]) = _$FeatureSetGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FeatureSetGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FeatureSetGet> get serializer => _$FeatureSetGetSerializer();
}

class _$FeatureSetGetSerializer implements PrimitiveSerializer<FeatureSetGet> {
  @override
  final Iterable<Type> types = const [FeatureSetGet, _$FeatureSetGet];

  @override
  final String wireName = r'FeatureSetGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FeatureSetGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FeatureSetGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FeatureSetGetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FeatureSetGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FeatureSetGetBuilder();
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

