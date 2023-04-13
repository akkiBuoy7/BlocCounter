import 'package:bloc_tutorial/bloc_methods/bloc/method_counter_bloc.dart';
import 'package:bloc_tutorial/communication_bloc/bloc/internet_bloc.dart';
import 'package:bloc_tutorial/communication_bloc/utility/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../communication_cubit/utility/constants.dart';
import '../bloc/method_internet_bloc.dart';
import '../utility/method_constants.dart';

class BlocMethodsHomePage extends StatefulWidget {
  const BlocMethodsHomePage({super.key, required this.title});

  final String title;

  @override
  State<BlocMethodsHomePage> createState() => _BlocMethodsHomePageState();
}

class _BlocMethodsHomePageState extends State<BlocMethodsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: screenBlocs(),
    );
  }

  Widget screenBlocs() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildConnectivityText(), buildCounterText(),
          buildButtons(),
          // context.watch()
          Builder(builder: (context) {
            final internetState = context.watch<MethodInternetBloc>().state;
            final counterState = context.watch<MethodCounterBloc>().state;

            if (internetState is MethodInternetConnectedState &&
                internetState.connectionType == MethodConnectivityType.WIFI) {
              return Text(
                'Internet : WIFI / Counter : ${counterState.counterValue}',
                style: TextStyle(color: Colors.red, fontSize: 20),
              );
            } else if (internetState is MethodInternetConnectedState &&
                internetState.connectionType == MethodConnectivityType.MOBILE) {
              return Text(
                'Internet: MOBILE / Counter : ${counterState.counterValue}',
                style: TextStyle(color: Colors.red, fontSize: 20),
              );
            } else {
              return Text(
                'Internet DISCONNECTED / Counter : ${counterState.counterValue}',
                style: TextStyle(color: Colors.red, fontSize: 20),
              );
            }
            ;
          }),
          // context.select
          Builder(
            builder: (context) {
              final counterValue = context
                  .select((MethodCounterBloc bloc) => bloc.state.counterValue);
              return Text(
                'Select Counter: ' + counterValue.toString(),
                style: Theme.of(context).textTheme.headline6,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildConnectivityText() {
    return BlocBuilder<MethodInternetBloc, MethodInternetState>(
      builder: (context, state) {
        if (state is MethodInternetConnectedState &&
            state.connectionType == MethodConnectivityType.WIFI) {
          return Text(
            'WIFI',
            style: TextStyle(color: Colors.red, fontSize: 20),
          );
        } else if (state is MethodInternetConnectedState &&
            state.connectionType == MethodConnectivityType.MOBILE) {
          return Text(
            'MOBILE',
            style: TextStyle(color: Colors.red, fontSize: 20),
          );
        } else {
          return Text(
            'DISCONNECTED',
            style: TextStyle(color: Colors.red, fontSize: 20),
          );
        }
      },
    );
  }

  Widget buildCounterText() {
    return BlocBuilder<MethodCounterBloc, MethodCounterState>(
      builder: (context, state) {
        if (state.counterValue < 0) {
          return Text(
            'Negative ${state.counterValue}',
            style: Theme.of(context).textTheme.headlineMedium,
          );
        } else {
          return Text(
            'Positive ${state.counterValue}',
            style: Theme.of(context).textTheme.headlineMedium,
          );
        }
      },
    );
  }

  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FloatingActionButton(
          heroTag: null,
          onPressed: () {
            // BlocProvider.of<MethodCounterBloc>(context)
            //     .add(IncrementMethodCounterEvent());

            // context.read()
            context
                .read<MethodCounterBloc>()
                .add(IncrementMethodCounterEvent());
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: () {
            // BlocProvider.of<MethodCounterBloc>(context)
            //     .add(DecrementMethodCounterEvent());

            context
                .read<MethodCounterBloc>()
                .add(DecrementMethodCounterEvent());
          },
          tooltip: 'Decrement',
          child: const Icon(Icons.minimize),
        ),
      ],
    );
  }
}

/*
 context.watch helps to get the state of multiple blocs in single context

 context.select can be used in place of buildWhen
 When we want to build a widget based on the change in value of only a
 single field in the bloc class, then we should use this.

 Both wtach and select will rebuild the widget based on a state , so they are
 used within Builder.

 context.read will help to access the current provided instance of the
 bloc and call add method of bloc for passing event  or any function of cubit

 */
