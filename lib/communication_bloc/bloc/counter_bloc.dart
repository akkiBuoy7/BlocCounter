import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../communication_cubit/utility/constants.dart';
import 'internet_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBlocCommunication extends Bloc<CounterEvent, CounterBlocState> {

  final InternetBlocCommunication internetBloc;
  StreamSubscription? internetStreamSubscription;


  CounterBlocCommunication(this.internetBloc) : super(CounterBlocInitialState(counterValue1: 0)) {

    monitorCounter();

    on<IncrementCounterEvent>((event, emit) {
      emit(CounterBlocIncrementState(counterValue1: state.counterValue+1)) ;
    });
    on<DecrementCounterEvent>((event, emit) {
      emit(CounterBlocDecrementState(counterValue1: state.counterValue-1)) ;
    });
  }

void monitorCounter() {
  internetStreamSubscription = internetBloc.stream.listen((internetState) {
    if (internetState is InternetConnected &&
        internetState.connectionType == ConnectivityType.WIFI) {
      add(IncrementCounterEvent());
    } else if (internetState is InternetConnected &&
        internetState.connectionType == ConnectivityType.MOBILE) {
      add(DecrementCounterEvent());
    }
  });
}

@override
  Future<void> close() {
  internetStreamSubscription?.cancel();
    return super.close();
  }
}
