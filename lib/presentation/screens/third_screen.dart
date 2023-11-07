import 'package:bloc_counter/bloc/info/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter/counter.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key, required this.color, required this.title});

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
                Navigator.pop(context);
              },
              child: const Text('<| Back'),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: 'second screen fab 1',
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(Increment(by: 10));
              BlocProvider.of<AuthBloc>(context).add(
                  SignInEvent(userName: 'AlbanyBuipe', password: 'password'));
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            heroTag: 'second screen fab 2',
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
