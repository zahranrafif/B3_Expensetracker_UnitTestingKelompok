// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  late final String id;
  late final String uid;
  late final String name;
  late final String email;
  late final int balance;
  UserModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.balance,
  });

  UserModel copyWith({
    String? id,
    String? uid,
    String? name,
    String? email,
    int? balance,
  }) {
    return UserModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'name': name,
      'email': email,
      'balance': balance,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      balance: map['balance'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, uid: $uid, name: $name, email: $email, balance: $balance)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.balance == balance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      balance.hashCode;
  }
}
