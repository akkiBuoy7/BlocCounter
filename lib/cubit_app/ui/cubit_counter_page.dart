import 'package:bloc_tutorial/cubit_app/cubit/counter_cubit.dart';
import 'package:bloc_tutorial/cubit_app/ui/cubit_second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCubitCounterPage extends StatefulWidget {
  const MyCubitCounterPage({super.key, required this.title});

  final String title;

  @override
  State<MyCubitCounterPage> createState() => _MyCubitCounterPageState();
}

class _MyCubitCounterPageState extends State<MyCubitCounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: usingBlocConsumer()
        //usingBlocListener(),
        //usingBlocProvider(),
        );
  }

  Widget usingBlocProvider() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          BlocBuilder<CounterCubit, CounterCubitState>(
            builder: (context, state) {
              if (state.counterValue < 0) {
                return Text(
                  'Negative>>> ${state.counterValue.toString()}',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else if (state.counterValue == 0) {
                return Text(
                  'Initial>>> ${state.counterValue.toString()}',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else {
                return Text(
                  'Positive>>> ${state.counterValue.toString()}',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).increment();
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).decrement();
                },
                tooltip: 'Decrement',
                child: const Icon(Icons.minimize),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<CounterCubit>(context),
                        child: MyCubitCounterSecondPage(
                          title: 'Second screen Cubit',
                        ),
                      )));
                },
                child: Text("Second Screen")),
          )
        ],
      ),
    );
  }

  /*
  A bloc provider can be triggered multiple times, so if we use this to show
  a snackbar it will show that many snackbars.
  So to provide Navigator Route, Toast, SnackBar etc we should use Bloc Listener
   */
  Widget usingBlocListener() {
    return BlocListener<CounterCubit, CounterCubitState>(
      listener: (context1, state) {
        if (state is CounterCubitIncrementState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("incremented"),
            duration: Duration(microseconds: 1000),
          ));
        } else if (state is CounterCubitDecrementState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("decremented"),
            duration: Duration(microseconds: 1000),
          ));
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterCubit, CounterCubitState>(
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'Negative>>> ${state.counterValue.toString()}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                } else if (state.counterValue == 0) {
                  return Text(
                    'Initial>>> ${state.counterValue.toString()}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                } else {
                  return Text(
                    'Positive>>> ${state.counterValue.toString()}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.minimize),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<CounterCubit>(context),
                          child: MyCubitCounterSecondPage(
                            title: 'Second screen Cubit',
                          ),
                        )));
                  },
                  child: Text("Second Screen")),
            )
          ],
        ),
      ),
    );
  }

  /*
  Using a blocConsumer we can do both.
  Using builder we will build UI.
  Using Listener we will trigger events like snackBar, Routing, Toast etc.
   */
  Widget usingBlocConsumer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          BlocConsumer<CounterCubit, CounterCubitState>(
            listener: (context, state) {
              if (state is CounterCubitIncrementState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("incremented"),
                  duration: Duration(microseconds: 1000),
                ));
              } else if (state is CounterCubitDecrementState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("decremented"),
                  duration: Duration(microseconds: 1000),
                ));
              }
            },
            builder: (context, state) {
              if (state.counterValue < 0) {
                return Text(
                  'Negative>>> ${state.counterValue.toString()}',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else if (state.counterValue == 0) {
                return Text(
                  'Initial>>> ${state.counterValue.toString()}',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else {
                return Text(
                  'Positive>>> ${state.counterValue.toString()}',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).increment();
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).decrement();
                },
                tooltip: 'Decrement',
                child: const Icon(Icons.minimize),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<CounterCubit>(context),
                            child: MyCubitCounterSecondPage(
                              title: 'Second screen Cubit',
                            ),
                          )));
                },
                child: Text("Second Screen")),
          )
        ],
      ),
    );
  }
}
/*
BlocProvider.value =>
  value : This will provide the same instance of bloc to next screen
  Use the context carefully, don't use MaterialPageRoute builder context
 */
