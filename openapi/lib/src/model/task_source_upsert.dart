//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_source_upsert.g.dart';

/// TaskSourceUpsert
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [rootCode] 
/// * [keepConnection] 
/// * [url] 
/// * [sourceId] 
@BuiltValue()
abstract class TaskSourceUpsert implements Built<TaskSourceUpsert, TaskSourceUpsertBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'root_code')
  String get rootCode;

  @BuiltValueField(wireName: r'keep_connection')
  bool get keepConnection;

  @BuiltValueField(wireName: r'url')
  String get url;

  @BuiltValueField(wireName: r'source_id')
  int get sourceId;

  TaskSourceUpsert._();

  factory TaskSourceUpsert([void updates(TaskSourceUpsertBuilder b)]) = _$TaskSourceUpsert;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskSourceUpsertBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskSourceUpsert> get serializer => _$TaskSourceUpsertSerializer();
}

class _$TaskSourceUpsertSerializer implements PrimitiveSerializer<TaskSourceUpsert> {
  @override
  final Iterable<Type> types = const [TaskSourceUpsert, _$TaskSourceUpsert];

  @override
  final String wireName = r'TaskSourceUpsert';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskSourceUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'root_code';
    yield serializers.serialize(
      object.rootCode,
      specifiedType: const FullType(String),
    );
    yield r'keep_connection';
    yield serializers.serialize(
      object.keepConnection,
      specifiedType: const FullType(bool),
    );
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
    yield r'source_id';
    yield serializers.serialize(
      object.sourceId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskSourceUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskSourceUpsertBuilder result,
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
        case r'root_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rootCode = valueDes;
          break;
        case r'keep_connection':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.keepConnection = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'source_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sourceId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaskSourceUpsert deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskSourceUpsertBuilder();
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

