//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_source_get.g.dart';

/// TaskSourceGet
///
/// Properties:
/// * [id] 
/// * [sourceId] 
/// * [code] 
/// * [rootCode] 
/// * [url] 
/// * [state] 
/// * [stateDetails] 
/// * [updatedOn] 
/// * [keepConnection] 
@BuiltValue()
abstract class TaskSourceGet implements Built<TaskSourceGet, TaskSourceGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'source_id')
  int get sourceId;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'root_code')
  String get rootCode;

  @BuiltValueField(wireName: r'url')
  String get url;

  @BuiltValueField(wireName: r'state')
  String? get state;

  @BuiltValueField(wireName: r'state_details')
  String? get stateDetails;

  @BuiltValueField(wireName: r'updated_on')
  DateTime get updatedOn;

  @BuiltValueField(wireName: r'keep_connection')
  bool? get keepConnection;

  TaskSourceGet._();

  factory TaskSourceGet([void updates(TaskSourceGetBuilder b)]) = _$TaskSourceGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskSourceGetBuilder b) => b
      ..state = 'UNKNOWN'
      ..keepConnection = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskSourceGet> get serializer => _$TaskSourceGetSerializer();
}

class _$TaskSourceGetSerializer implements PrimitiveSerializer<TaskSourceGet> {
  @override
  final Iterable<Type> types = const [TaskSourceGet, _$TaskSourceGet];

  @override
  final String wireName = r'TaskSourceGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskSourceGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'source_id';
    yield serializers.serialize(
      object.sourceId,
      specifiedType: const FullType(int),
    );
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
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
    if (object.state != null) {
      yield r'state';
      yield serializers.serialize(
        object.state,
        specifiedType: const FullType(String),
      );
    }
    if (object.stateDetails != null) {
      yield r'state_details';
      yield serializers.serialize(
        object.stateDetails,
        specifiedType: const FullType(String),
      );
    }
    yield r'updated_on';
    yield serializers.serialize(
      object.updatedOn,
      specifiedType: const FullType(DateTime),
    );
    if (object.keepConnection != null) {
      yield r'keep_connection';
      yield serializers.serialize(
        object.keepConnection,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskSourceGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskSourceGetBuilder result,
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
        case r'source_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sourceId = valueDes;
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
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.state = valueDes;
          break;
        case r'state_details':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.stateDetails = valueDes;
          break;
        case r'updated_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedOn = valueDes;
          break;
        case r'keep_connection':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.keepConnection = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaskSourceGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskSourceGetBuilder();
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

