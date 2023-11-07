part of 'counter_cubit.dart';

@immutable
class CounterState extends Equatable {
  final int value;
  final bool isIncremented;

  const CounterState({
    required this.value,
    required this.isIncremented,
  });

  @override
  List<Object?> get props => [
        value,
        isIncremented,
      ];
}
