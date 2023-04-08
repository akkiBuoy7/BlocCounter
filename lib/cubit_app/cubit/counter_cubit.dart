import 'package:bloc/bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterCubitState> {
  CounterCubit() : super(CounterCubitInitialState(counterValue1: 0));

  void increment() =>
      emit(CounterCubitIncrementState(counterValue1: state.counterValue + 1));

  void decrement() =>
      emit(CounterCubitDecrementState(counterValue1: state.counterValue - 1));
}
