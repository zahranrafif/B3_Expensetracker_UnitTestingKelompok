// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthRegisterModel {
  final bool status;
  final String message;
  final AuthRegisterData? data;
  AuthRegisterModel({
    required this.status,
    required this.message,
    this.data,
  });

  AuthRegisterModel copyWith({
    bool? status,
    String? message,
    AuthRegisterData? data,
  }) {
    return AuthRegisterModel(
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

  factory AuthRegisterModel.fromMap(Map<String, dynamic> map) {
    return AuthRegisterModel(
      status: map['status'] as bool,
      message: map['message'] as String,
      data: map['data'] != null ? AuthRegisterData.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRegisterModel.fromJson(String source) => AuthRegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthRegisterModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant AuthRegisterModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.message == message &&
      other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class AuthRegisterData {
  final String uid;
  final String? email;
  AuthRegisterData({
    required this.uid,
    this.email,
  });

  AuthRegisterData copyWith({
    String? uid,
    String? email,
  }) {
    return AuthRegisterData(
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

  factory AuthRegisterData.fromMap(Map<String, dynamic> map) {
    return AuthRegisterData(
      uid: map['uid'] as String,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRegisterData.fromJson(String source) => AuthRegisterData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthRegisterData(uid: $uid, email: $email)';

  @override
  bool operator ==(covariant AuthRegisterData other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;
}
