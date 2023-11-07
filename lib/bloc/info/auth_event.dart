part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class SignInEvent extends AuthEvent {
  // final String token;
  final String userName;
  final String password;

  SignInEvent({required this.userName, required this.password});

  @override
  List<Object?> get props => [userName, password];
}

class SignOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
