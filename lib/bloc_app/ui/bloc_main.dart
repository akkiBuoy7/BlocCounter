import 'package:bloc_tutorial/bloc_app/bloc/counter_bloc.dart';
import 'package:bloc_tutorial/bloc_app/ui/bloc_counter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utility/util.dart';
import 'bloc_second_screen.dart';
import 'bloc_third_screen.dart';

/*
  Sharing same instance of CounterBloc across three screens.
  Need to use stateful widget if using BlocProvider.value in order to override
  the dispose method for closing blocs manually.
  When using BlocProvider the dispose method not required because blocs get
  closed automatically.
 */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterBloc _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: MyUtil.HOME_ROUTE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        MyUtil.HOME_ROUTE: (context) => BlocProvider.value(
              value: _counterBloc,
              child: MyBlocCounterPage(
                title: 'Bloc First Page',
              ),
            ),
        MyUtil.FIRST_ROUTE: (context) => BlocProvider.value(
              value: _counterBloc,
              child: MyBlocSecondCounterPage(
                title: 'Bloc Second Page',
              ),
            ),
        MyUtil.SECOND_ROUTE: (context) => BlocProvider.value(
              value: _counterBloc,
              child: MyBlocThirdCounterPage(
                title: 'Bloc Third Page',
              ),
            )
      },
    );
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }
}

/*
BlocProvider.value() => Uses a single bloc instance across multiple screens
BlocProvider => Creates Multiple Instances for each screen
 */
