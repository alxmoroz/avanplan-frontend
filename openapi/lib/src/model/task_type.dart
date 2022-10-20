//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_type.g.dart';

/// TaskType
///
/// Properties:
/// * [title] 
@BuiltValue()
abstract class TaskType implements Built<TaskType, TaskTypeBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  TaskType._();

  factory TaskType([void updates(TaskTypeBuilder b)]) = _$TaskType;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskTypeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskType> get serializer => _$TaskTypeSerializer();
}

class _$TaskTypeSerializer implements PrimitiveSerializer<TaskType> {
  @override
  final Iterable<Type> types = const [TaskType, _$TaskType];

  @override
  final String wireName = r'TaskType';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskType object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskType object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskTypeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  TaskType deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskTypeBuilder();
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

