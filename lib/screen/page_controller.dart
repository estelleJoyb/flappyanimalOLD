import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flappyanimal/provider/flappyanimal_provider.dart';
import 'package:flappyanimal/screen/page_menu.dart';

class PagesController extends StatefulWidget {
  const PagesController({Key? key}) : super(key: key);

  @override
  _PagesControllerState createState() => _PagesControllerState();
}

class _PagesControllerState extends State<PagesController> {
  // void goExit() {
  //   Navigator.pop(context);
  //   goConnexion();
  // }

  // void goConnexion() {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => ConnectionScreen(goSelectionStock, goExit,
  //               apiPostItemQueryFind, getToken, goParameters)));
  // }

  // void goParameters() {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => ParameterScreen(goConnexion)));
  // }

  // void goSelectionStock() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => SelectionStockScreen(goStockQuantity, goExit)),
  //   );
  // }

  // void goStockQuantity() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => StockQuantityScreen(goSupplier, goConsignee,
  //             goExit, supplierQueryFind, consigneeQueryFind)),
  //   );
  // }

  // void goSupplier() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => SupplierScreen(okSupplier, goExit)),
  //   );
  // }

  // void goConsignee() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => ConsigneeScreen(okConsignee, goExit)),
  //   );
  // }

  // void okSupplier() {
  //   goStockQuantity(); //to edit
  // }

  // void okConsignee() {
  //   goStockQuantity(); //to edit
  // }

  // Future<String> getToken(WidgetRef ref) async {
  //   print("get token");
  //   //print("cert : ${ref.watch(providerDemo).cert.asInt8List()}");
  //   //print("key : ${ref.watch(providerDemo).key.asInt8List()}");
  //   String stringtoken = (await ApiService().getToken(
  //       ref.watch(providerDemo).certPath, ref.watch(providerDemo).keyPath))!;
  //   //String stringtoken = (await ApiService().getToken(
  //   //    ref.watch(providerDemo).certPath, ref.watch(providerDemo).keyPath))!;
  //   await Future.delayed(const Duration(seconds: 1));
  //   if (stringtoken.isNotEmpty) {
  //     final jsontoken = json.decode(stringtoken);
  //     String token = jsontoken['access_token'];
  //     String refreshToken = jsontoken['refresh_token'];
  //     ref.watch(providerDemo.notifier).setToken("Bearer $token");
  //     ref.watch(providerDemo.notifier).setRefreshToken(refreshToken);

  //     return token;
  //   }
  //   return "";
  // }

  // Future<HashMap> apiPostItemQueryFind(WidgetRef ref) async {
  //   print("apiPostItemQueryFind");
  //   HashMap itemMap = await ApiService().itemQueryFind(ref);
  //   await Future.delayed(const Duration(seconds: 1));
  //   print("itemMap:  $itemMap");
  //   if (itemMap.isNotEmpty) {
  //     itemMap.forEach((key, value) {
  //       print(key);
  //       print(value);
  //     });
  //     ref.watch(providerDemo.notifier).setItemMap(itemMap);
  //     return itemMap;
  //   } else {
  //     return itemMap;
  //   }
  // }

  // Future<HashMap> supplierQueryFind(WidgetRef ref) async {
  //   print("get supplier ");
  //   HashMap supplierMap = await ApiService().supplierQueryFind(ref);
  //   await Future.delayed(const Duration(seconds: 1));
  //   print("supplier map : $supplierMap");
  //   List<String> suppliers = [];
  //   supplierMap.forEach((key, value) {
  //     suppliers.add(key);
  //   });
  //   ref.watch(providerDemo.notifier).setSuppliers(suppliers);
  //   return supplierMap;
  // }

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
    return const Scaffold(body: MenuScreen("hello"));
  }
}
