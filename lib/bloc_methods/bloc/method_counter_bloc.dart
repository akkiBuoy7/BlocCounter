import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../communication_bloc/utility/constants.dart';
import '../utility/method_constants.dart';
import 'method_internet_bloc.dart';

part 'method_counter_event.dart';
part 'method_counter_state.dart';

class MethodCounterBloc extends Bloc<MethodCounterEvent, MethodCounterState> {

  final MethodInternetBloc internetBloc;
  StreamSubscription? internetStreamSubscription;



  MethodCounterBloc(this.internetBloc) : super(MethodCounterInitial(counterValue1: 0)) {
    on<MethodCounterEvent>((event, emit) {


      on<IncrementMethodCounterEvent>((event, emit) {
        emit(MethodCounterIncrementState(counterValue1: state.counterValue+1)) ;
      });
      on<DecrementMethodCounterEvent>((event, emit) {
        emit(MethodCounterDecrementState(counterValue1: state.counterValue-1)) ;
      });
    });
  }

  @override
  Future<void> close() {
    internetStreamSubscription?.cancel();
    return super.close();
  }
}


