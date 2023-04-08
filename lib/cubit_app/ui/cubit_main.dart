import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/counter_cubit.dart';
import 'cubit_counter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => CounterCubit(),
          child: const MyCubitCounterPage(title: 'Cubit Counter First Page')),
    );
  }
}

/*
 If using Anonymous routing then need to wrap home screen with BlocProvider
 Next screens can be provided with BlocProvider.value while routing
 */
