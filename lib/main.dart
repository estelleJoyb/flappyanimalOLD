import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flappyanimal/screen/page_controller.dart';
//import 'package:visibility/API/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
      child: MaterialApp(
    title: "flappy animal",
    home: PagesController(),
  )));
}
