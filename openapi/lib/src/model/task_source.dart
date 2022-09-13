//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_source.g.dart';

/// TaskSource
///
/// Properties:
/// * [code] 
/// * [rootCode] 
/// * [keepConnection] 
/// * [url] 
/// * [parentCode] 
/// * [versionCode] 
@BuiltValue()
abstract class TaskSource implements Built<TaskSource, TaskSourceBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'root_code')
  String get rootCode;

  @BuiltValueField(wireName: r'keep_connection')
  bool get keepConnection;

  @BuiltValueField(wireName: r'url')
  String? get url;

  @BuiltValueField(wireName: r'parent_code')
  String? get parentCode;

  @BuiltValueField(wireName: r'version_code')
  String? get versionCode;

  TaskSource._();

  factory TaskSource([void updates(TaskSourceBuilder b)]) = _$TaskSource;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskSourceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskSource> get serializer => _$TaskSourceSerializer();
}

class _$TaskSourceSerializer implements PrimitiveSerializer<TaskSource> {
  @override
  final Iterable<Type> types = const [TaskSource, _$TaskSource];

  @override
  final String wireName = r'TaskSource';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskSource object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    if (object.url != null) {
      yield r'url';
      yield serializers.serialize(
        object.url,
        specifiedType: const FullType(String),
      );
    }
    if (object.parentCode != null) {
      yield r'parent_code';
      yield serializers.serialize(
        object.parentCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.versionCode != null) {
      yield r'version_code';
      yield serializers.serialize(
        object.versionCode,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskSource object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskSourceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'parent_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.parentCode = valueDes;
          break;
        case r'version_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.versionCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaskSource deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskSourceBuilder();
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

