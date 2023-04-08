import 'package:bloc_tutorial/generated_route/ui/bloc_second_screen_generated.dart';
import 'package:bloc_tutorial/generated_route/utility/util_generated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_app/bloc/counter_bloc.dart';
import '../ui/bloc_counter_page_generated.dart';
import '../ui/bloc_third_screen_generated.dart';

class AppRouter {
  final CounterBloc _counterBloc = CounterBloc();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case MyUtilGenerated.HOME_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _counterBloc,
                  child: MyBlocCounterPageGenerated(
                    title: 'First Screen Generated',
                  ),
                ));
        break;
      case MyUtilGenerated.FIRST_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _counterBloc,
                  child: MyBlocSecondCounterGeneratedPage(
                    title: 'Second Screen Generated',
                  ),
                ));
        break;
      case MyUtilGenerated.SECOND_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _counterBloc,
                  child: MyBlocThirdCounterGeneratedPage(
                    title: 'Third Screen Generated',
                  ),
                ));
        break;
      default:
        return null;
    }
  }
}
