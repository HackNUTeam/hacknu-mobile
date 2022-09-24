import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacknu_mobile/core/local_storage.dart';
import 'package:hacknu_mobile/feature/auth/model/user_data.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginAuthEvent>((event, emit) async {
      emit(LoadingAuthState());
      await Future.delayed(const Duration(seconds: 1));
      event.user.id = _getRandomInt();
      CustomLocalStorage.saveUser(user: event.user);
      emit(AuthenticatedAuthState(user: event.user));
    });

    on<InitAuthEvent>(
      (event, emit) async {
        emit(LoadingAuthState());
        final user = await CustomLocalStorage.getUser();
        if (user != null) {
          emit(AuthenticatedAuthState(user: user));
        } else {
          emit(UnauthenticatedAuthState());
        }
      },
    );
    on<LogoutEvent>((event, emit) async {
      emit(LoadingAuthState());
      await CustomLocalStorage.removeUser();
      emit(UnauthenticatedAuthState());
    });
  }

  int _getRandomInt() {
    var r = Random();
    return r.nextInt(100);
  }
}
