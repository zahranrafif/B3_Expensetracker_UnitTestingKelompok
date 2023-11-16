part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthError extends AuthState {
  final String error;

  const AuthError({
    required this.error
  });

  @override
  List<Object> get props => [error];
}

// * Login
class AuthLoginLoading extends AuthState {}
class AuthLoginLoaded extends AuthState {
  final AuthLoginModel response;

  const AuthLoginLoaded({
    required this.response
  });

  @override
  List<Object> get props => [response];
}

// * Register
class AuthRegisterLoading extends AuthState {}
class AuthRegisterLoaded extends AuthState {
  final AuthRegisterModel response;

  const AuthRegisterLoaded({
    required this.response
  });

  @override
  List<Object> get props => [response];
}

// * Logout
class AuthLogoutLoaded extends AuthState {}