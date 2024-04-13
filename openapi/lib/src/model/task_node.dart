//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/task_get.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_node.g.dart';

/// TaskNode
///
/// Properties:
/// * [root] 
/// * [subtasks] 
@BuiltValue()
abstract class TaskNode implements Built<TaskNode, TaskNodeBuilder> {
  @BuiltValueField(wireName: r'root')
  TaskGet get root;

  @BuiltValueField(wireName: r'subtasks')
  BuiltList<TaskGet> get subtasks;

  TaskNode._();

  factory TaskNode([void updates(TaskNodeBuilder b)]) = _$TaskNode;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskNodeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskNode> get serializer => _$TaskNodeSerializer();
}

class _$TaskNodeSerializer implements PrimitiveSerializer<TaskNode> {
  @override
  final Iterable<Type> types = const [TaskNode, _$TaskNode];

  @override
  final String wireName = r'TaskNode';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskNode object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'root';
    yield serializers.serialize(
      object.root,
      specifiedType: const FullType(TaskGet),
    );
    yield r'subtasks';
    yield serializers.serialize(
      object.subtasks,
      specifiedType: const FullType(BuiltList, [FullType(TaskGet)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskNode object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskNodeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'root':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TaskGet),
          ) as TaskGet;
          result.root.replace(valueDes);
          break;
        case r'subtasks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TaskGet)]),
          ) as BuiltList<TaskGet>;
          result.subtasks.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaskNode deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskNodeBuilder();
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

