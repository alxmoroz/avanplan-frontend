//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'msg.g.dart';

/// Msg
///
/// Properties:
/// * [msg] 
abstract class Msg implements Built<Msg, MsgBuilder> {
    @BuiltValueField(wireName: r'msg')
    String get msg;

    Msg._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(MsgBuilder b) => b;

    factory Msg([void updates(MsgBuilder b)]) = _$Msg;

    @BuiltValueSerializer(custom: true)
    static Serializer<Msg> get serializer => _$MsgSerializer();
}

class _$MsgSerializer implements StructuredSerializer<Msg> {
    @override
    final Iterable<Type> types = const [Msg, _$Msg];

    @override
    final String wireName = r'Msg';

    @override
    Iterable<Object?> serialize(Serializers serializers, Msg object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'msg')
            ..add(serializers.serialize(object.msg,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    Msg deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = MsgBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'msg':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.msg = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

