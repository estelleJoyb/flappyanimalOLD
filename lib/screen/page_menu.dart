import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flappyanimal/provider/flappyanimal_provider.dart';

class MenuScreen extends ConsumerWidget {
  final String test;
  const MenuScreen(
    this.test, {
    super.key,
  });
  //pour utiliser le provider : ref.watch(providerDemo.notifier).setErreur("truc");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(child: Text(test)),
    );
  }
}
