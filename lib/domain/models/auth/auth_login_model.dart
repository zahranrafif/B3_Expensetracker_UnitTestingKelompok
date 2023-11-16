// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthLoginModel {
  final bool status;
  final String message;
  final AuthLoginData? data;
  AuthLoginModel({
    required this.status,
    required this.message,
    this.data,
  });

  AuthLoginModel copyWith({
    bool? status,
    String? message,
    AuthLoginData? data,
  }) {
    return AuthLoginModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory AuthLoginModel.fromMap(Map<String, dynamic> map) {
    return AuthLoginModel(
      status: map['status'] as bool,
      message: map['message'] as String,
      data: map['data'] != null ? AuthLoginData.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthLoginModel.fromJson(String source) => AuthLoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthLoginModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant AuthLoginModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.message == message &&
      other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class AuthLoginData {
  final String uid;
  final String? email;
  AuthLoginData({
    required this.uid,
    this.email,
  });

  AuthLoginData copyWith({
    String? uid,
    String? email,
  }) {
    return AuthLoginData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
    };
  }

  factory AuthLoginData.fromMap(Map<String, dynamic> map) {
    return AuthLoginData(
      uid: map['uid'] as String,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthLoginData.fromJson(String source) => AuthLoginData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthLoginData(uid: $uid, email: $email)';

  @override
  bool operator ==(covariant AuthLoginData other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;
}
