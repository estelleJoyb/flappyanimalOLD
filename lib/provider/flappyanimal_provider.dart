import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flappyanimal/modele/modele.dart';

Flappyanimal _flappyanimal = Flappyanimal();

class FlappyanimalNotifier extends StateNotifier<Flappyanimal> {
  FlappyanimalNotifier() : super(_flappyanimal);

  //Setters
  void setlogin(String l) {
    Flappyanimal newFlappyanimal = state.cloneFlappyanimal();
    newFlappyanimal.setLogin(l);
    state = newFlappyanimal;
  }
}

final providerFlappyanimal =
    StateNotifierProvider<FlappyanimalNotifier, Flappyanimal>(
        (ref) => FlappyanimalNotifier());
