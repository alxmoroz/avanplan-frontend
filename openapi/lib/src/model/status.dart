//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'status.g.dart';

/// Status
///
/// Properties:
/// * [closed] 
/// * [title] 
@BuiltValue()
abstract class Status implements Built<Status, StatusBuilder> {
  @BuiltValueField(wireName: r'closed')
  bool get closed;

  @BuiltValueField(wireName: r'title')
  String get title;

  Status._();

  factory Status([void updates(StatusBuilder b)]) = _$Status;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StatusBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Status> get serializer => _$StatusSerializer();
}

class _$StatusSerializer implements PrimitiveSerializer<Status> {
  @override
  final Iterable<Type> types = const [Status, _$Status];

  @override
  final String wireName = r'Status';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Status object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'closed';
    yield serializers.serialize(
      object.closed,
      specifiedType: const FullType(bool),
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
    Status object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StatusBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'closed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.closed = valueDes;
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
  Status deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StatusBuilder();
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

