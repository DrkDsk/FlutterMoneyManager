import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class BlocSideEffectListener<B extends BlocBase, E> extends StatefulWidget {
  final B bloc;
  final void Function(BuildContext context, E effect) listener;
  final Widget child;

  const BlocSideEffectListener({
    super.key,
    required this.bloc,
    required this.listener,
    required this.child,
  });

  @override
  State<BlocSideEffectListener<B, E>> createState() =>
      _BlocSideEffectListenerState<B, E>();
}

class _BlocSideEffectListenerState<B extends BlocBase, E>
    extends State<BlocSideEffectListener<B, E>> {
  late final StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _sub = (widget.bloc as dynamic).sideEffects.listen((effect) {
      widget.listener(context, effect as E);
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
