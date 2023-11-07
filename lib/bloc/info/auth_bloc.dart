import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

const String _userName = 'AlbanyBuipe';
const String _password = 'password';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(status: false, token: '')) {
    on<AuthEvent>((event, emit) {
      if (event is SignInEvent) {
        if (event.userName == _userName && event.password == _password) {
          emit(
            AuthState(
              status: true,
              token: '${event.userName}${Random().nextInt(100)}',
            ),
          );
        }
      } else {
        emit(const AuthState(status: false, token: ''));
      }
    });
  }
}
