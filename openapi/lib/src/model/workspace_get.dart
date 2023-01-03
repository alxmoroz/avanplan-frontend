//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/priority_get.dart';
import 'package:openapi/src/model/source_get.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/person_get.dart';
import 'package:openapi/src/model/status_get.dart';
import 'package:openapi/src/model/ws_settings_get.dart';
import 'package:openapi/src/model/estimate_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workspace_get.g.dart';

/// WorkspaceGet
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [title] 
/// * [description] 
/// * [statuses] 
/// * [priorities] 
/// * [persons] 
/// * [sources] 
/// * [estimates] 
/// * [settings] 
@BuiltValue()
abstract class WorkspaceGet implements Built<WorkspaceGet, WorkspaceGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'statuses')
  BuiltList<StatusGet> get statuses;

  @BuiltValueField(wireName: r'priorities')
  BuiltList<PriorityGet> get priorities;

  @BuiltValueField(wireName: r'persons')
  BuiltList<PersonGet> get persons;

  @BuiltValueField(wireName: r'sources')
  BuiltList<SourceGet> get sources;

  @BuiltValueField(wireName: r'estimates')
  BuiltList<EstimateGet> get estimates;

  @BuiltValueField(wireName: r'settings')
  WSSettingsGet get settings;

  WorkspaceGet._();

  factory WorkspaceGet([void updates(WorkspaceGetBuilder b)]) = _$WorkspaceGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkspaceGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkspaceGet> get serializer => _$WorkspaceGetSerializer();
}

class _$WorkspaceGetSerializer implements PrimitiveSerializer<WorkspaceGet> {
  @override
  final Iterable<Type> types = const [WorkspaceGet, _$WorkspaceGet];

  @override
  final String wireName = r'WorkspaceGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkspaceGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
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
    yield r'statuses';
    yield serializers.serialize(
      object.statuses,
      specifiedType: const FullType(BuiltList, [FullType(StatusGet)]),
    );
    yield r'priorities';
    yield serializers.serialize(
      object.priorities,
      specifiedType: const FullType(BuiltList, [FullType(PriorityGet)]),
    );
    yield r'persons';
    yield serializers.serialize(
      object.persons,
      specifiedType: const FullType(BuiltList, [FullType(PersonGet)]),
    );
    yield r'sources';
    yield serializers.serialize(
      object.sources,
      specifiedType: const FullType(BuiltList, [FullType(SourceGet)]),
    );
    yield r'estimates';
    yield serializers.serialize(
      object.estimates,
      specifiedType: const FullType(BuiltList, [FullType(EstimateGet)]),
    );
    yield r'settings';
    yield serializers.serialize(
      object.settings,
      specifiedType: const FullType(WSSettingsGet),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkspaceGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WorkspaceGetBuilder result,
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
        case r'statuses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StatusGet)]),
          ) as BuiltList<StatusGet>;
          result.statuses.replace(valueDes);
          break;
        case r'priorities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PriorityGet)]),
          ) as BuiltList<PriorityGet>;
          result.priorities.replace(valueDes);
          break;
        case r'persons':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PersonGet)]),
          ) as BuiltList<PersonGet>;
          result.persons.replace(valueDes);
          break;
        case r'sources':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SourceGet)]),
          ) as BuiltList<SourceGet>;
          result.sources.replace(valueDes);
          break;
        case r'estimates':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EstimateGet)]),
          ) as BuiltList<EstimateGet>;
          result.estimates.replace(valueDes);
          break;
        case r'settings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WSSettingsGet),
          ) as WSSettingsGet;
          result.settings.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkspaceGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkspaceGetBuilder();
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

