part of 'auth_bloc.dart';

@immutable
class AuthState {
  final String token;
  final bool status;

  const AuthState({required this.status, required this.token});
}
