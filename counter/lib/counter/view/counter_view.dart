import 'package:counter/counter/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Counter')),
        body: Center(
          child: BlocBuilder<CounterCubit, int>(
              builder: (context, state) => Text(
                    state.toString(),
                    style: Theme.of(context).textTheme.headline2,
                  )),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: BlocProvider.of<CounterCubit>(context).increment,
              child: const Icon(Icons.add),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: BlocProvider.of<CounterCubit>(context).decrement,
              child: const Icon(Icons.remove),
            )
          ],
        ),
      );
}
