import 'package:bloc_counter/bloc/counter/counter.dart';
import 'package:bloc_counter/bloc/internet/internet_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterBloc', () {
    late CounterBloc bloc;

    setUp(() {
      bloc = CounterBloc(
        internetCubit: InternetCubit(
          connectivity: Connectivity(),
        ),
      );
    });

    tearDown(() => bloc.close());

    test(
      'Initial state of CounterBloc: CounterState(value: 0, isIncremented: false)',
      () => expect(
        bloc.state,
        const CounterState(value: 0, isIncremented: false),
      ),
    );

    blocTest(
      'CounterBloc emits a CounterState(value: 2, isIncremented: true)',
      build: () => bloc,
      act: (bloc) => [Increment(by: 2)],
      expect: () => [const CounterState(value: 2, isIncremented: true)],
    );

    blocTest(
      'CounterBloc emits a CounterState(value: -2, isIncremented: false)',
      build: () => bloc,
      act: (bloc) => [Decrement(by: 2)],
      expect: () => [const CounterState(value: -2, isIncremented: false)],
    );
  });
}
