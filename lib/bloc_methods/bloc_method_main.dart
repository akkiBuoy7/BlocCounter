import 'package:bloc_tutorial/bloc_methods/bloc/method_counter_bloc.dart';
import 'package:bloc_tutorial/bloc_methods/bloc/method_internet_bloc.dart';
import 'package:bloc_tutorial/bloc_methods/ui/bloc_method_counter_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        BlocProvider<MethodInternetBloc>(
          create: (context) => MethodInternetBloc(connectivity),
        ),
        BlocProvider<MethodCounterBloc>(
          create: (context) =>
              MethodCounterBloc(BlocProvider.of<MethodInternetBloc>(context)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: BlocMethodsHomePage(
          title: 'Bloc Method',
        ),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
