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
/// * [type] 
/// * [category] 
/// * [icon] 
/// * [taskSource] 
@BuiltValue()
abstract class TaskRemote implements Built<TaskRemote, TaskRemoteBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'type')
  String? get type;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'icon')
  String? get icon;

  @BuiltValueField(wireName: r'task_source')
  TaskSource get taskSource;

  TaskRemote._();

  factory TaskRemote([void updates(TaskRemoteBuilder b)]) = _$TaskRemote;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskRemoteBuilder b) => b
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
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(String),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    if (object.icon != null) {
      yield r'icon';
      yield serializers.serialize(
        object.icon,
        specifiedType: const FullType(String),
      );
    }
    yield r'task_source';
    yield serializers.serialize(
      object.taskSource,
      specifiedType: const FullType(TaskSource),
    );
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
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'icon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.icon = valueDes;
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

