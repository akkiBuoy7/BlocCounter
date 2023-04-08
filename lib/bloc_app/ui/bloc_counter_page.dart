import 'package:bloc_tutorial/bloc_app/bloc/counter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utility/util.dart';

class MyBlocCounterPage extends StatefulWidget {
  const MyBlocCounterPage({super.key, required this.title});

  final String title;

  @override
  State<MyBlocCounterPage> createState() => _MyBlocCounterPageState();
}

class _MyBlocCounterPageState extends State<MyBlocCounterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: usingBlocListener()
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
          BlocBuilder<CounterBloc, CounterBlocState>(
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
                  BlocProvider.of<CounterBloc>(context).add(IncrementCounterEvent());
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).add(DecrementCounterEvent());
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
                  Navigator.of(context).pushNamed(MyUtil.FIRST_ROUTE);
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
    return BlocListener<CounterBloc, CounterBlocState>(
      listener: (context1, state) {
        if (state is CounterBlocIncrementState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("incremented"),
            duration: Duration(microseconds: 1000),
          ));
        } else if (state is CounterBlocDecrementState) {
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
            BlocBuilder<CounterBloc, CounterBlocState>(
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
                  heroTag: null,
                  onPressed: () {
                    BlocProvider.of<CounterBloc>(context).add(IncrementCounterEvent());
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    BlocProvider.of<CounterBloc>(context).add(DecrementCounterEvent());
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
                    Navigator.pushNamed(context,MyUtil.FIRST_ROUTE);
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
          BlocConsumer<CounterBloc, CounterBlocState>(
            listener: (context,state){
              if (state is CounterBlocIncrementState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("incremented"),
                  duration: Duration(microseconds: 1000),
                ));
              } else if (state is CounterBlocDecrementState) {
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
                  BlocProvider.of<CounterBloc>(context).add(IncrementCounterEvent());
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).add(DecrementCounterEvent());
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
                  Navigator.of(context).pushNamed(MyUtil.FIRST_ROUTE);
                },
                child: Text("Second Screen")),
          )
        ],
      ),
    );
  }
}