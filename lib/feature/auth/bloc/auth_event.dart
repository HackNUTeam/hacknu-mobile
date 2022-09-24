part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class InitAuthEvent extends AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final UserData user;

  LoginAuthEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class LogoutEvent extends AuthEvent {}
