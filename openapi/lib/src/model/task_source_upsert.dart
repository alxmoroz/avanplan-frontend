//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

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

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TaskSourceUpsertBuilder b) => b;

    factory TaskSourceUpsert([void updates(TaskSourceUpsertBuilder b)]) = _$TaskSourceUpsert;

    @BuiltValueSerializer(custom: true)
    static Serializer<TaskSourceUpsert> get serializer => _$TaskSourceUpsertSerializer();
}

class _$TaskSourceUpsertSerializer implements StructuredSerializer<TaskSourceUpsert> {
    @override
    final Iterable<Type> types = const [TaskSourceUpsert, _$TaskSourceUpsert];

    @override
    final String wireName = r'TaskSourceUpsert';

    @override
    Iterable<Object?> serialize(Serializers serializers, TaskSourceUpsert object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(int)));
        }
        result
            ..add(r'code')
            ..add(serializers.serialize(object.code,
                specifiedType: const FullType(String)));
        result
            ..add(r'root_code')
            ..add(serializers.serialize(object.rootCode,
                specifiedType: const FullType(String)));
        result
            ..add(r'keep_connection')
            ..add(serializers.serialize(object.keepConnection,
                specifiedType: const FullType(bool)));
        result
            ..add(r'url')
            ..add(serializers.serialize(object.url,
                specifiedType: const FullType(String)));
        result
            ..add(r'source_id')
            ..add(serializers.serialize(object.sourceId,
                specifiedType: const FullType(int)));
        return result;
    }

    @override
    TaskSourceUpsert deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TaskSourceUpsertBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.id = valueDes;
                    break;
                case r'code':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.code = valueDes;
                    break;
                case r'root_code':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.rootCode = valueDes;
                    break;
                case r'keep_connection':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.keepConnection = valueDes;
                    break;
                case r'url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.url = valueDes;
                    break;
                case r'source_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.sourceId = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

