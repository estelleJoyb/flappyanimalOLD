import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Flappyanimal {
  String login = "";

  Flappyanimal(); //constructor

  //Setters
  void setLogin(String l) {
    login = l;
  }

  Flappyanimal cloneFlappyanimal() {
    Flappyanimal newFlappyanimal = Flappyanimal();
    newFlappyanimal.login = login;
    return newFlappyanimal;
  }
}
