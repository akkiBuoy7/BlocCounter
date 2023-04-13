import 'package:bloc_tutorial/state_update/ui/SettingsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/settings_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext myAppContext) {
    return BlocProvider(
      create: (BuildContext context) {
        return SettingsCubit();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        home: SettingsScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
