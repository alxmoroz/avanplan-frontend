//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'priority.g.dart';

/// Priority
///
/// Properties:
/// * [order] 
/// * [code] 
@BuiltValue()
abstract class Priority implements Built<Priority, PriorityBuilder> {
  @BuiltValueField(wireName: r'order')
  int get order;

  @BuiltValueField(wireName: r'code')
  String get code;

  Priority._();

  factory Priority([void updates(PriorityBuilder b)]) = _$Priority;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PriorityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Priority> get serializer => _$PrioritySerializer();
}

class _$PrioritySerializer implements PrimitiveSerializer<Priority> {
  @override
  final Iterable<Type> types = const [Priority, _$Priority];

  @override
  final String wireName = r'Priority';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Priority object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'order';
    yield serializers.serialize(
      object.order,
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
    Priority object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PriorityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.order = valueDes;
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
  Priority deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PriorityBuilder();
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

