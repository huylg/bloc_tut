part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object?> get props => [];
}

class TimerStarted extends TimerEvent {
  const TimerStarted();
}

class TimerResume extends TimerEvent {
  const TimerResume();
}

class TimerTicked extends TimerEvent {
  const TimerTicked(this.duration) : super();
  final int duration;

  @override
  List<Object?> get props => [duration];
}

class TimerPause extends TimerEvent {
  const TimerPause();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}
