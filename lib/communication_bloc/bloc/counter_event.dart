part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}


class InitialCounterEvent extends CounterEvent{

}

class IncrementCounterEvent extends CounterEvent{

}

class DecrementCounterEvent extends CounterEvent{

}