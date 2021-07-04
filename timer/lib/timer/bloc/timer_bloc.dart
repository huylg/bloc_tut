import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timer/timer/bloc/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({required this.ticker, required this.initialDuration})
      : assert(initialDuration <= 3600),
        super(TimerInitial(initialDuration));

  final Ticker ticker;
  StreamSubscription<int>? subscription;
  final int initialDuration;
  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStarted)
      _mapTimerStartedEventToState(event);
    else if (event is TimerTicked)
      yield _mapTimerTickedEventToState(event);
    else if (event is TimerPause)
      yield _mapTimerPauseEventToState(event);
    else if (event is TimerResume)
      yield _mapTimerResumeEventToState(event);
    else if (event is TimerReset) yield _mapTimerResetEventToState(event);
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }

  TimerState _mapTimerResetEventToState(TimerReset event) {
    subscription?.cancel();
    return TimerInitial(initialDuration);
  }

  TimerState _mapTimerResumeEventToState(TimerResume event) {
    subscription?.resume();
    return TimerRunInProgress(state.duration);
  }

  TimerState _mapTimerPauseEventToState(TimerPause event) {
    subscription?.pause();
    return TimerRunInPause(state.duration);
  }

  TimerState _mapTimerTickedEventToState(TimerTicked event) =>
      event.duration > 0
          ? TimerRunInProgress(event.duration)
          : TimerRunComplete();

  void _mapTimerStartedEventToState(TimerStarted event) async {
    subscription?.cancel();
    subscription = ticker
        .tick(ticks: initialDuration)
        .listen((duration) => add(TimerTicked(duration)));
  }
}
