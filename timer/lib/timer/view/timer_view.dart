import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/timer/bloc/timer_bloc.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Background(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: TimerText(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Action(),
            )
          ],
        ),
      ]),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration =
        context.select((TimerBloc timerBloc) => timerBloc.state.duration);

    final minutesString = (duration ~/ 60).toString().padLeft(2, '0');
    final secondsString = (duration % 60).toString().padLeft(2, '0');
    return Text(
      '$minutesString:$secondsString',
      style: Theme.of(context).textTheme.headline2,
    );
  }
}

class Action extends StatelessWidget {
  const Action({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (previousState, currentState) =>
          previousState.runtimeType != currentState.runtimeType,
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (state is TimerInitial)
            FloatingActionButton(
              onPressed: () => context.read<TimerBloc>().add(TimerStarted()),
              child: Icon(Icons.play_arrow),
            )
          else if (state is TimerRunInProgress) ...[
            FloatingActionButton(
              onPressed: () => context.read<TimerBloc>().add(TimerPause()),
              child: Icon(Icons.pause),
            ),
            FloatingActionButton(
              onPressed: () => context.read<TimerBloc>().add(TimerReset()),
              child: Icon(Icons.replay),
            )
          ] else if (state is TimerRunInPause) ...[
            FloatingActionButton(
              onPressed: () => context.read<TimerBloc>().add(TimerResume()),
              child: Icon(Icons.play_arrow),
            ),
            FloatingActionButton(
              onPressed: () => context.read<TimerBloc>().add(TimerReset()),
              child: Icon(Icons.replay),
            )
          ] else if (state is TimerRunComplete)
            FloatingActionButton(
              onPressed: () => context.read<TimerBloc>().add(TimerStarted()),
              child: Icon(Icons.play_arrow),
            )
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade50, Colors.blue.shade500])),
    );
  }
}
