import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sembast_test/pages/AppListing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'SemBast POC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppListingPage()
      // const AddPage()
    );
  }
}


