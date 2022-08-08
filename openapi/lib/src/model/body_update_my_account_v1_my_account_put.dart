//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_update_my_account_v1_my_account_put.g.dart';

/// BodyUpdateMyAccountV1MyAccountPut
///
/// Properties:
/// * [password] 
/// * [fullName] 
abstract class BodyUpdateMyAccountV1MyAccountPut implements Built<BodyUpdateMyAccountV1MyAccountPut, BodyUpdateMyAccountV1MyAccountPutBuilder> {
    @BuiltValueField(wireName: r'password')
    String? get password;

    @BuiltValueField(wireName: r'full_name')
    String? get fullName;

    BodyUpdateMyAccountV1MyAccountPut._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(BodyUpdateMyAccountV1MyAccountPutBuilder b) => b;

    factory BodyUpdateMyAccountV1MyAccountPut([void updates(BodyUpdateMyAccountV1MyAccountPutBuilder b)]) = _$BodyUpdateMyAccountV1MyAccountPut;

    @BuiltValueSerializer(custom: true)
    static Serializer<BodyUpdateMyAccountV1MyAccountPut> get serializer => _$BodyUpdateMyAccountV1MyAccountPutSerializer();
}

class _$BodyUpdateMyAccountV1MyAccountPutSerializer implements StructuredSerializer<BodyUpdateMyAccountV1MyAccountPut> {
    @override
    final Iterable<Type> types = const [BodyUpdateMyAccountV1MyAccountPut, _$BodyUpdateMyAccountV1MyAccountPut];

    @override
    final String wireName = r'BodyUpdateMyAccountV1MyAccountPut';

    @override
    Iterable<Object?> serialize(Serializers serializers, BodyUpdateMyAccountV1MyAccountPut object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.password != null) {
            result
                ..add(r'password')
                ..add(serializers.serialize(object.password,
                    specifiedType: const FullType(String)));
        }
        if (object.fullName != null) {
            result
                ..add(r'full_name')
                ..add(serializers.serialize(object.fullName,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    BodyUpdateMyAccountV1MyAccountPut deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = BodyUpdateMyAccountV1MyAccountPutBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'password':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.password = valueDes;
                    break;
                case r'full_name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.fullName = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

