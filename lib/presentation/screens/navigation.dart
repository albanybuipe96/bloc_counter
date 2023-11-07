import 'package:bloc_counter/bloc/counter/counter.dart';
import 'package:bloc_counter/bloc/internet/internet_cubit.dart';
import 'package:bloc_counter/presentation/screens/home_screen.dart';
import 'package:bloc_counter/presentation/screens/second_screen.dart';
import 'package:bloc_counter/presentation/screens/third_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) =>
              HomeScreen(title: 'Bloc Counter', color: Colors.orange[300]),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) =>
              SecondScreen(color: Colors.blue[400], title: 'Second Screen'),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) =>
              ThirdScreen(color: Colors.green[400], title: 'Third Screen'),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              HomeScreen(title: 'Bloc Counter', color: Colors.orange[300]),
        );
    }
  }
}

class AppRouter2 {
  final CounterBloc _counterBloc =
      CounterBloc(internetCubit: InternetCubit(connectivity: Connectivity()));

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _counterBloc,
            child: HomeScreen(title: 'Bloc Counter', color: Colors.orange[300]),
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _counterBloc,
            child:
                SecondScreen(color: Colors.blue[400], title: 'Second Screen'),
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _counterBloc,
            child: ThirdScreen(color: Colors.green[400], title: 'Third Screen'),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _counterBloc,
            child: HomeScreen(title: 'Bloc Counter', color: Colors.orange[300]),
          ),
        );
    }
  }

  void dispose() {
    _counterBloc.close();
  }
}
