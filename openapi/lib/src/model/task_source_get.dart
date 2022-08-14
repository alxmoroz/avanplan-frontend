//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:openapi/src/model/source_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_source_get.g.dart';

/// TaskSourceGet
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [keepConnection] 
/// * [url] 
/// * [source_] 
abstract class TaskSourceGet implements Built<TaskSourceGet, TaskSourceGetBuilder> {
    @BuiltValueField(wireName: r'id')
    int get id;

    @BuiltValueField(wireName: r'code')
    String get code;

    @BuiltValueField(wireName: r'keep_connection')
    bool get keepConnection;

    @BuiltValueField(wireName: r'url')
    String get url;

    @BuiltValueField(wireName: r'source')
    SourceGet get source_;

    TaskSourceGet._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TaskSourceGetBuilder b) => b;

    factory TaskSourceGet([void updates(TaskSourceGetBuilder b)]) = _$TaskSourceGet;

    @BuiltValueSerializer(custom: true)
    static Serializer<TaskSourceGet> get serializer => _$TaskSourceGetSerializer();
}

class _$TaskSourceGetSerializer implements StructuredSerializer<TaskSourceGet> {
    @override
    final Iterable<Type> types = const [TaskSourceGet, _$TaskSourceGet];

    @override
    final String wireName = r'TaskSourceGet';

    @override
    Iterable<Object?> serialize(Serializers serializers, TaskSourceGet object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(int)));
        result
            ..add(r'code')
            ..add(serializers.serialize(object.code,
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
            ..add(r'source')
            ..add(serializers.serialize(object.source_,
                specifiedType: const FullType(SourceGet)));
        return result;
    }

    @override
    TaskSourceGet deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TaskSourceGetBuilder();

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
                case r'source':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(SourceGet)) as SourceGet;
                    result.source_.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

