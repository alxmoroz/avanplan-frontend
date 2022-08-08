//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_get.g.dart';

/// UserGet
///
/// Properties:
/// * [id] 
/// * [email] 
/// * [password] 
/// * [fullName] 
abstract class UserGet implements Built<UserGet, UserGetBuilder> {
    @BuiltValueField(wireName: r'id')
    int get id;

    @BuiltValueField(wireName: r'email')
    String get email;

    @BuiltValueField(wireName: r'password')
    String get password;

    @BuiltValueField(wireName: r'full_name')
    String? get fullName;

    UserGet._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UserGetBuilder b) => b;

    factory UserGet([void updates(UserGetBuilder b)]) = _$UserGet;

    @BuiltValueSerializer(custom: true)
    static Serializer<UserGet> get serializer => _$UserGetSerializer();
}

class _$UserGetSerializer implements StructuredSerializer<UserGet> {
    @override
    final Iterable<Type> types = const [UserGet, _$UserGet];

    @override
    final String wireName = r'UserGet';

    @override
    Iterable<Object?> serialize(Serializers serializers, UserGet object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(int)));
        result
            ..add(r'email')
            ..add(serializers.serialize(object.email,
                specifiedType: const FullType(String)));
        result
            ..add(r'password')
            ..add(serializers.serialize(object.password,
                specifiedType: const FullType(String)));
        if (object.fullName != null) {
            result
                ..add(r'full_name')
                ..add(serializers.serialize(object.fullName,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    UserGet deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserGetBuilder();

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
                case r'email':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.email = valueDes;
                    break;
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

