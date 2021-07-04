part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object?> get props => [duration];

  @override
  String toString() => '$runtimeType {duration: $duration}';
}

class TimerInitial extends TimerState {
  TimerInitial(int duration) : super(duration);
}

class TimerRunInProgress extends TimerState {
  TimerRunInProgress(int duration) : super(duration);
}

class TimerRunInPause extends TimerState {
  TimerRunInPause(int duration) : super(duration);
}

class TimerRunComplete extends TimerState {
  TimerRunComplete() : super(0);
}
