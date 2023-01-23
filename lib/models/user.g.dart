// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      uid: json['uid'] as String,
      pic: json['pic'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      followers: json['followers'] as List<dynamic>,
      patient: json['patient'] as List<dynamic>,
      bloodtype: json['bloodtype'] as String,
      age: json['age'] as String,
      usertype: json['usertype'] as String,
      category: json['category'],
      scedule: json['scedule'] as String?,
      gender: json['gender'] as String?,
      phonenumber: json['phonenumber'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'uid': instance.uid,
      'pic': instance.pic,
      'name': instance.name,
      'bio': instance.bio,
      'bloodtype': instance.bloodtype,
      'age': instance.age,
      'followers': instance.followers,
      'patient': instance.patient,
      'usertype': instance.usertype,
      'category': instance.category,
      'scedule': instance.scedule,
      'gender': instance.gender,
      'phonenumber': instance.phonenumber,
    };
