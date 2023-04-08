import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterBlocState> {
  CounterBloc() : super(CounterBlocInitialState(counterValue1: 0)) {
    on<IncrementCounterEvent>((event, emit) {
      emit(CounterBlocIncrementState(counterValue1: state.counterValue+1)) ;
    });
    on<DecrementCounterEvent>((event, emit) {
      emit(CounterBlocDecrementState(counterValue1: state.counterValue-1)) ;
    });
  }
}
