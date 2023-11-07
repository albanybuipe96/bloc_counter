import 'package:bloc_counter/bloc/internet/internet_cubit.dart';
import 'package:bloc_counter/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter/counter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.color, required this.title});

  final Color? color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bloc Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.WiFi) {
                  return Text(
                    'Connected to WiFi!',
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                }

                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return Text(
                    'Connected to Mobile!',
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                }

                if (state is InternetDisconnected) {
                  return Text(
                    'No internet connection!',
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterBloc, CounterState>(
              listener: (context, state) {
                if (state.isIncremented) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Counter incremented.'),
                    duration: Duration(milliseconds: 300),
                  ));
                }
              },
              builder: (context, state) {
                return Text(
                  '${state.value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
              child: const Text('Next Screen'),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: 'home screen fab 1',
            onPressed: () =>
                BlocProvider.of<CounterBloc>(context).add(Increment(by: 10)),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            heroTag: 'home screen fab 2',
            onPressed: () =>
                BlocProvider.of<CounterBloc>(context).add(Decrement(by: 5)),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
