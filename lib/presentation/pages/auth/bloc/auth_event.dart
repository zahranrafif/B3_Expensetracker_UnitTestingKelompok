part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({
    required this.email,
    required this.password
  });
}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const AuthRegister({
    required this.email,
    required this.password,
    required this.name
  });
}

class AuthLogout extends AuthEvent {}