//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'source_type_get.g.dart';

/// SourceTypeGet
///
/// Properties:
/// * [id] 
/// * [title] 
@BuiltValue()
abstract class SourceTypeGet implements Built<SourceTypeGet, SourceTypeGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'title')
  String get title;

  SourceTypeGet._();

  factory SourceTypeGet([void updates(SourceTypeGetBuilder b)]) = _$SourceTypeGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SourceTypeGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SourceTypeGet> get serializer => _$SourceTypeGetSerializer();
}

class _$SourceTypeGetSerializer implements PrimitiveSerializer<SourceTypeGet> {
  @override
  final Iterable<Type> types = const [SourceTypeGet, _$SourceTypeGet];

  @override
  final String wireName = r'SourceTypeGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SourceTypeGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SourceTypeGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SourceTypeGetBuilder result,
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SourceTypeGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SourceTypeGetBuilder();
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

