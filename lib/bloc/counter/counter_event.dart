
import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  late final int by;
}

class Neither extends CounterEvent {
  final int by = 0;
  @override
  List<Object?> get props => [by];
}

class Increment extends CounterEvent {
  final int by;

  Increment({this.by = 1});

  @override
  List<Object?> get props => [by];
}

class Decrement extends CounterEvent {
  final int by;

  Decrement({this.by = 1});

  @override
  List<Object?> get props => [by];
}