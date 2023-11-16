import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:expensetracker/domain/models/auth/auth_login_model.dart';
import 'package:expensetracker/domain/models/auth/auth_register_model.dart';
import 'package:expensetracker/domain/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
    });

    on<AuthLogin>((event, emit) async {
      try {
        emit(AuthLoginLoading());
        final response = await authRepository.login(event.email, event.password);
          
        emit(AuthLoginLoaded(response: response));
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });

    on<AuthRegister>((event, emit) async {
      try {
        emit(AuthRegisterLoading());

        final response = await authRepository.register(event.email, event.password, event.name);
        
        emit(AuthRegisterLoaded(response: response));

      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });

    on<AuthLogout>((event, emit) async {
      try {
        await authRepository.logout();
          
        emit(AuthLogoutLoaded());
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
  }
}
