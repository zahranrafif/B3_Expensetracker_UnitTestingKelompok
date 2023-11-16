part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileError extends ProfileState {
  final String error;

  const ProfileError({
    required this.error
  });

  @override
  List<Object> get props => [error];
}

class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final UserModel data;

  const ProfileLoaded({
    required this.data
  });

  @override
  List<Object> get props => [data];
}