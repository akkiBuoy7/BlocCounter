part of 'method_counter_bloc.dart';

@immutable
abstract class MethodCounterState {

  int counterValue;

  MethodCounterState(this.counterValue);
}

class MethodCounterInitial extends MethodCounterState {
  int counterValue1;

  MethodCounterInitial({required this.counterValue1}) : super(counterValue1);
}

class MethodCounterIncrementState extends MethodCounterState {
  int counterValue1;

  MethodCounterIncrementState({required this.counterValue1}) : super(counterValue1);
}

class MethodCounterDecrementState extends MethodCounterState {
  int counterValue1;

  MethodCounterDecrementState({required this.counterValue1}) : super(counterValue1);
}
