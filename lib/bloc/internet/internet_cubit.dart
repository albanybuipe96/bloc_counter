import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_counter/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    observeInternetConnection(connectivity);
  }

  internetConnected(ConnectionType type) =>
      emit(InternetConnected(connectionType: type));

  internetDisconnected() => emit(InternetDisconnected());

  observeInternetConnection(Connectivity connectivity) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi) {
        internetConnected(ConnectionType.WiFi);
      }
      if (result == ConnectivityResult.mobile) {
        internetConnected(ConnectionType.Mobile);
      }

      if (result == ConnectivityResult.none) {
        internetDisconnected();
      }
    });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
