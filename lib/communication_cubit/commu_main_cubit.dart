import 'package:bloc_tutorial/communication_cubit/ui/home_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit_app/cubit/counter_cubit.dart';
import '../main.dart';
import 'cubit/counter_cubit.dart';
import 'cubit/internet_cubit.dart';

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
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubitCommunication>(
          create: (context) => CounterCubitCommunication(internetCubit:
          BlocProvider.of<InternetCubit>(context)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: CubitCommunicationHomePage(title: 'Cubit Communication',),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}


