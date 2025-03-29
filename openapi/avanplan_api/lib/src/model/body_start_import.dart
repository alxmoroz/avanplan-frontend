//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:avanplan_api/src/model/task_remote.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_start_import.g.dart';

/// BodyStartImport
///
/// Properties:
/// * [projects]
@BuiltValue()
abstract class BodyStartImport implements Built<BodyStartImport, BodyStartImportBuilder> {
  @BuiltValueField(wireName: r'projects')
  BuiltList<TaskRemote> get projects;

  BodyStartImport._();

  factory BodyStartImport([void updates(BodyStartImportBuilder b)]) = _$BodyStartImport;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyStartImportBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyStartImport> get serializer => _$BodyStartImportSerializer();
}

class _$BodyStartImportSerializer implements PrimitiveSerializer<BodyStartImport> {
  @override
  final Iterable<Type> types = const [BodyStartImport, _$BodyStartImport];

  @override
  final String wireName = r'BodyStartImport';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyStartImport object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'projects';
    yield serializers.serialize(
      object.projects,
      specifiedType: const FullType(BuiltList, [FullType(TaskRemote)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyStartImport object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyStartImportBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'projects':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TaskRemote)]),
          ) as BuiltList<TaskRemote>;
          result.projects.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyStartImport deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyStartImportBuilder();
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
