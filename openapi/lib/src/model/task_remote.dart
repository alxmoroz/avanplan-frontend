//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/task_source.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_remote.g.dart';

/// TaskRemote
///
/// Properties:
/// * [title] 
/// * [description] 
/// * [closed] 
/// * [type] 
/// * [startDate] 
/// * [dueDate] 
/// * [closedDate] 
/// * [estimate] 
/// * [taskSource] 
@BuiltValue()
abstract class TaskRemote implements Built<TaskRemote, TaskRemoteBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'closed')
  bool? get closed;

  @BuiltValueField(wireName: r'type')
  String? get type;

  @BuiltValueField(wireName: r'start_date')
  DateTime? get startDate;

  @BuiltValueField(wireName: r'due_date')
  DateTime? get dueDate;

  @BuiltValueField(wireName: r'closed_date')
  DateTime? get closedDate;

  @BuiltValueField(wireName: r'estimate')
  num? get estimate;

  @BuiltValueField(wireName: r'task_source')
  TaskSource? get taskSource;

  TaskRemote._();

  factory TaskRemote([void updates(TaskRemoteBuilder b)]) = _$TaskRemote;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskRemoteBuilder b) => b
      ..closed = false
      ..type = 'TASK';

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskRemote> get serializer => _$TaskRemoteSerializer();
}

class _$TaskRemoteSerializer implements PrimitiveSerializer<TaskRemote> {
  @override
  final Iterable<Type> types = const [TaskRemote, _$TaskRemote];

  @override
  final String wireName = r'TaskRemote';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskRemote object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.closed != null) {
      yield r'closed';
      yield serializers.serialize(
        object.closed,
        specifiedType: const FullType(bool),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(String),
      );
    }
    if (object.startDate != null) {
      yield r'start_date';
      yield serializers.serialize(
        object.startDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.dueDate != null) {
      yield r'due_date';
      yield serializers.serialize(
        object.dueDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.closedDate != null) {
      yield r'closed_date';
      yield serializers.serialize(
        object.closedDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.estimate != null) {
      yield r'estimate';
      yield serializers.serialize(
        object.estimate,
        specifiedType: const FullType(num),
      );
    }
    if (object.taskSource != null) {
      yield r'task_source';
      yield serializers.serialize(
        object.taskSource,
        specifiedType: const FullType(TaskSource),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskRemote object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskRemoteBuilder result,
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
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'closed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.closed = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'start_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startDate = valueDes;
          break;
        case r'due_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.dueDate = valueDes;
          break;
        case r'closed_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.closedDate = valueDes;
          break;
        case r'estimate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.estimate = valueDes;
          break;
        case r'task_source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TaskSource),
          ) as TaskSource;
          result.taskSource.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaskRemote deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskRemoteBuilder();
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

