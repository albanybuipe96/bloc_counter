import 'package:bloc_counter/bloc/internet/internet_cubit.dart';
import 'package:bloc_counter/presentation/screens/home_screen.dart';
import 'package:bloc_counter/presentation/screens/navigation.dart';
import 'package:bloc_counter/presentation/screens/second_screen.dart';
import 'package:bloc_counter/presentation/screens/third_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter/counter.dart';
import 'bloc/info/auth_bloc.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.appRouter, required this.connectivity});

  final AppRouter appRouter;
  final Connectivity connectivity;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final InternetCubit internetCubit;

  @override
  void initState() {
    internetCubit = InternetCubit(connectivity: widget.connectivity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => internetCubit,
        ),
        BlocProvider(
          create: (context) => CounterBloc(internetCubit: internetCubit),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: widget.appRouter.onGenerateRoute,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
