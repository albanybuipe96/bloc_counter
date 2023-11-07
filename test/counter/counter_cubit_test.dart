import 'package:bloc_counter/bloc/counter/counter.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    late CounterCubit cubit;

    setUp(() => cubit = CounterCubit());

    tearDown(() => cubit.close());

    test(
      'Initial state of CounterCubit CounterState(value: 0, isIncremented: false)',
      () => expect(
        cubit.state,
        const CounterState(value: 0, isIncremented: false),
      ),
    );

    blocTest(
      'CounterCubit should emit a CounterState(value: 1, isIncremented: true)',
      build: () => cubit,
      act: (cubit) => cubit.increment(),
      expect: () => [
        const CounterState(value: 1, isIncremented: true),
      ],
    );

    blocTest(
      'CounterCubit should emit a CounterState(value: -1, isIncremented: false)',
      build: () => cubit,
      act: (cubit) => cubit.decrement(),
      expect: () => [
        const CounterState(value: -1, isIncremented: false),
      ],
    );
  });
}
