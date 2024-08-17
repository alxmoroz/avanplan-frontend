//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_repeat_upsert.g.dart';

/// TaskRepeatUpsert
///
/// Properties:
/// * [id] 
/// * [taskId] 
/// * [periodType] 
/// * [periodLength] 
/// * [daysList] 
@BuiltValue()
abstract class TaskRepeatUpsert implements Built<TaskRepeatUpsert, TaskRepeatUpsertBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'task_id')
  int get taskId;

  @BuiltValueField(wireName: r'period_type')
  String get periodType;

  @BuiltValueField(wireName: r'period_length')
  int get periodLength;

  @BuiltValueField(wireName: r'days_list')
  String get daysList;

  TaskRepeatUpsert._();

  factory TaskRepeatUpsert([void updates(TaskRepeatUpsertBuilder b)]) = _$TaskRepeatUpsert;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskRepeatUpsertBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskRepeatUpsert> get serializer => _$TaskRepeatUpsertSerializer();
}

class _$TaskRepeatUpsertSerializer implements PrimitiveSerializer<TaskRepeatUpsert> {
  @override
  final Iterable<Type> types = const [TaskRepeatUpsert, _$TaskRepeatUpsert];

  @override
  final String wireName = r'TaskRepeatUpsert';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskRepeatUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    yield r'task_id';
    yield serializers.serialize(
      object.taskId,
      specifiedType: const FullType(int),
    );
    yield r'period_type';
    yield serializers.serialize(
      object.periodType,
      specifiedType: const FullType(String),
    );
    yield r'period_length';
    yield serializers.serialize(
      object.periodLength,
      specifiedType: const FullType(int),
    );
    yield r'days_list';
    yield serializers.serialize(
      object.daysList,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskRepeatUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskRepeatUpsertBuilder result,
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
        case r'task_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.taskId = valueDes;
          break;
        case r'period_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.periodType = valueDes;
          break;
        case r'period_length':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.periodLength = valueDes;
          break;
        case r'days_list':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.daysList = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaskRepeatUpsert deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskRepeatUpsertBuilder();
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

