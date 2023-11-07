import 'dart:async';
import 'dart:developer';

import 'package:bloc_counter/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../internet/internet_cubit.dart';
import 'counter_cubit.dart';
import 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final InternetCubit internetCubit;
  late final StreamSubscription internetStreamSubscription;

  CounterBloc({required this.internetCubit})
      : super(const CounterState(value: 0, isIncremented: false)) {
    observeInternetCubit(internetCubit);

    on((CounterEvent event, emit) {
      if (event is Increment) {
        emit(CounterState(value: state.value + event.by, isIncremented: true));
      }

      if (event is Decrement) {
        emit(CounterState(value: state.value - event.by, isIncremented: false));
      }
    });
  }

  observeInternetCubit(InternetCubit internetCubit) {
    internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if (internetState is InternetLoading) {
        add(Neither());
      }

      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.WiFi) {
        add(Increment());
      }

      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) {
        add(Decrement());
      }
    });
  }

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
    log('${event.runtimeType} event fired with a value of ${event.by}',
        name: '$runtimeType');
  }

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
