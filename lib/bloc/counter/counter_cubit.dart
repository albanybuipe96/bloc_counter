
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(value: 0, isIncremented: false));

  increment() =>
      emit(CounterState(value: state.value + 1, isIncremented: true));

  decrement() =>
      emit(CounterState(value: state.value - 1, isIncremented: false));
}
