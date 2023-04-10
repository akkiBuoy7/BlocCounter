import 'package:bloc_tutorial/communication_bloc/ui/home_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_bloc.dart';
import 'bloc/internet_bloc.dart';

void main() {
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;

  const MyApp({
    super.key,
    required this.connectivity,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetBlocCommunication>(
          create: (context) => InternetBlocCommunication(connectivity),
        ),
        BlocProvider<CounterBlocCommunication>(
          create: (context) => CounterBlocCommunication(
          BlocProvider.of<InternetBlocCommunication>(context)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: BlocCommunicationHomePage(title: 'Bloc Communication',),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}