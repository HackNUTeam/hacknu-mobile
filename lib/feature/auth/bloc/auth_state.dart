part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  final String message;

  FailureAuthState(this.message);

  @override
  List<Object> get props => [message];
}

class AuthenticatedAuthState extends AuthState {
  final UserData user;

  AuthenticatedAuthState({required this.user});

  @override
  List<Object> get props => [user];
}

class UnauthenticatedAuthState extends AuthState {}
