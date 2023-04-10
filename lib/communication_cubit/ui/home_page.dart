import 'package:bloc_tutorial/communication_cubit/cubit/counter_cubit.dart';
import 'package:bloc_tutorial/communication_cubit/cubit/internet_cubit.dart';
import 'package:bloc_tutorial/communication_cubit/utility/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitCommunicationHomePage extends StatefulWidget {
  const CubitCommunicationHomePage({super.key, required this.title});

  final String title;

  @override
  State<CubitCommunicationHomePage> createState() =>
      _CubitCommunicationHomePageState();
}

class _CubitCommunicationHomePageState
    extends State<CubitCommunicationHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: communicateUsingListener(),
    );
  }

  /*
  Here we are using Bloc listener to listen to Internet cubit and then calling
  Counter Cubit functions , thus communicating directly here.
   */
  Widget communicateUsingListener() {
    return Center(
      child: BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state is InternetConnected &&
              state.connectionType == ConnectivityType.WIFI) {
            BlocProvider.of<CounterCubitCommunication>(context).increment();
          } else if (state is InternetConnected &&
              state.connectionType == ConnectivityType.MOBILE) {
            BlocProvider.of<CounterCubitCommunication>(context).decrement();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[buildConnectivityText(), buildCounterText()],
        ),
      ),
    );
  }

  Widget communicateUsingSubscription(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[buildConnectivityText(), buildCounterText()],
      ),
    );
  }

  Widget buildConnectivityText() {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectivityType.WIFI) {
          return Text(
            'WIFI',
            style: TextStyle(color: Colors.red, fontSize: 20),
          );
        } else if (state is InternetConnected &&
            state.connectionType == ConnectivityType.MOBILE) {
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
    return BlocBuilder<CounterCubitCommunication, CounterCubitState>(
      builder: (context, state) {
        if (state.counterValue < 0) {
          return Text(
            'Negative ${state.counterValue}',
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
          );
        } else {
          return Text(
            'Positive ${state.counterValue}',
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
          );
        }
      },
    );
  }
}
