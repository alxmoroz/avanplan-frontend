//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_source.g.dart';

/// TaskSource
///
/// Properties:
/// * [code] 
/// * [keepConnection] 
/// * [parentCode] 
/// * [versionCode] 
abstract class TaskSource implements Built<TaskSource, TaskSourceBuilder> {
    @BuiltValueField(wireName: r'code')
    String get code;

    @BuiltValueField(wireName: r'keep_connection')
    bool get keepConnection;

    @BuiltValueField(wireName: r'parent_code')
    String? get parentCode;

    @BuiltValueField(wireName: r'version_code')
    String? get versionCode;

    TaskSource._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TaskSourceBuilder b) => b;

    factory TaskSource([void updates(TaskSourceBuilder b)]) = _$TaskSource;

    @BuiltValueSerializer(custom: true)
    static Serializer<TaskSource> get serializer => _$TaskSourceSerializer();
}

class _$TaskSourceSerializer implements StructuredSerializer<TaskSource> {
    @override
    final Iterable<Type> types = const [TaskSource, _$TaskSource];

    @override
    final String wireName = r'TaskSource';

    @override
    Iterable<Object?> serialize(Serializers serializers, TaskSource object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'code')
            ..add(serializers.serialize(object.code,
                specifiedType: const FullType(String)));
        result
            ..add(r'keep_connection')
            ..add(serializers.serialize(object.keepConnection,
                specifiedType: const FullType(bool)));
        if (object.parentCode != null) {
            result
                ..add(r'parent_code')
                ..add(serializers.serialize(object.parentCode,
                    specifiedType: const FullType(String)));
        }
        if (object.versionCode != null) {
            result
                ..add(r'version_code')
                ..add(serializers.serialize(object.versionCode,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    TaskSource deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TaskSourceBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
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
                case r'parent_code':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.parentCode = valueDes;
                    break;
                case r'version_code':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.versionCode = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

