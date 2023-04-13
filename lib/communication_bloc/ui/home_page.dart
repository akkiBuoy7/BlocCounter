import 'package:bloc_tutorial/communication_bloc/bloc/internet_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../communication_cubit/utility/constants.dart';
import '../bloc/counter_bloc.dart';

class BlocCommunicationHomePage extends StatefulWidget {
  const BlocCommunicationHomePage({super.key, required this.title});

  final String title;

  @override
  State<BlocCommunicationHomePage> createState() =>
      _BlocCommunicationHomePageState();
}

class _BlocCommunicationHomePageState
    extends State<BlocCommunicationHomePage> {


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
      child: BlocListener<InternetBlocCommunication, InternetState>(
        listener: (context, state) {
          if (state is InternetConnected &&
              state.connectionType == ConnectivityType.WIFI) {
            BlocProvider.of<CounterBlocCommunication>(context). add(IncrementCounterEvent());
          } else if (state is InternetConnected &&
              state.connectionType == ConnectivityType.MOBILE) {
            BlocProvider.of<CounterBlocCommunication>(context). add(DecrementCounterEvent());
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
    return BlocBuilder<InternetBlocCommunication, InternetState>(
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
    return BlocBuilder<CounterBlocCommunication, CounterBlocState>(
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