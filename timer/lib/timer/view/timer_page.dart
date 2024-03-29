import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/timer/bloc/ticker.dart';
import 'package:timer/timer/bloc/timer_bloc.dart';
import 'package:timer/timer/view/timer_view.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker(), initialDuration: 60),
      child: const TimerView(),
    );
  }
}
