import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flappyanimal/screen/page_menu.dart';
import 'package:flappyanimal/screen/page_game.dart';
import 'package:flappyanimal/screen/page_scores.dart';

class PagesController extends StatefulWidget {
  const PagesController({Key? key}) : super(key: key);

  @override
  _PagesControllerState createState() => _PagesControllerState();
}

class _PagesControllerState extends State<PagesController> {
  void goBestScores() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScoreScreen(goExit, goMenu, goPlay)));
  }

  void goPlay() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GameScreen(goExit, goMenu, goBestScores)));
  }

  void goMenu() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MenuScreen(goExit, goPlay, goBestScores)));
  }

  void goExit() {
    Navigator.pop(context);
    goMenu();
  }

  // Future<HashMap> consigneeQueryFind(WidgetRef ref) async {
  //   print("get consignee");
  //   HashMap consigneeMap = await ApiService().consigneeQueryFind(ref);
  //   await Future.delayed(const Duration(seconds: 1));
  //   print("consignee map : $consigneeMap");
  //   List<String> consignees = [];
  //   consigneeMap.forEach((key, value) {
  //     consignees.add(key);
  //   });
  //   ref.watch(providerDemo.notifier).setConsignees(consignees);
  //   return consigneeMap;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MenuScreen(goExit, goPlay, goBestScores));
  }
}
