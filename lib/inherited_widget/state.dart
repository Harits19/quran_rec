import 'package:flutter/material.dart';

class MyState<TState, TAction> extends InheritedWidget {
  const MyState({
    super.key,
    required super.child,
    required this.state,
    this.action,
  });

  final TState state;
  final TAction? action;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class MyProvider<TState, TAction> extends StatelessWidget {
  const MyProvider({
    super.key,
    required this.builder,
    required this.state,
    required this.action,
  });

  final TState state;
  final TAction action;
  final StateBuilder<TState, TAction> builder;

  @override
  Widget build(BuildContext context) {
    return MyState(state: state, action: action, child: builder(state, action));
  }
}

typedef StateBuilder<TState, TAction> = Widget Function(TState, TAction);

typedef StateViewModel<TState, TAction> = MyState<TState, TAction>;
