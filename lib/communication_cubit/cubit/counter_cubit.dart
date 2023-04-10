import 'dart:async';

import 'package:bloc/bloc.dart';

import '../utility/constants.dart';
import 'internet_cubit.dart';

part 'counter_state.dart';

class CounterCubitCommunication extends Cubit<CounterCubitState> {
  final InternetCubit internetCubit;
  //StreamSubscription? internetStreamSubscription;

  CounterCubitCommunication({required this.internetCubit})
      : super(CounterCubitInitialState(counterValue1: 0)) {
   // monitorCounter();
  }

  // void monitorCounter() {
  //   internetStreamSubscription = internetCubit.stream.listen((internetState) {
  //     if (internetState is InternetConnected &&
  //         internetState.connectionType == ConnectivityType.WIFI) {
  //       increment();
  //     } else if (internetState is InternetConnected &&
  //         internetState.connectionType == ConnectivityType.MOBILE) {
  //       decrement();
  //     }
  //   });
  // }

  void increment() =>
      emit(CounterCubitIncrementState(counterValue1: state.counterValue + 1));

  void decrement() =>
      emit(CounterCubitDecrementState(counterValue1: state.counterValue - 1));


  // @override
  // Future<void> close() {
  //   internetStreamSubscription?.cancel();
  //   return super.close();
  // }

 /*
  CubitCommunication :
  Counter Cubit can listen to the state stream of Internet cubit using monitorCounter
  method and can call it's functions.
  Disadvantage is we have to manually close subscription in the close method.

  Instead we can use directly use bloc listener in the Ui screen for the Internet cubit
  which will directly listen to the state stream. Inside that we can call our
  Counter cubit instance to use it's functions.
  */
}

