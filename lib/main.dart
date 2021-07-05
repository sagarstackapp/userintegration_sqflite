import 'package:flutter/material.dart';
import 'package:userintegration_sqflite/common/constant/color_res.dart';
import 'package:userintegration_sqflite/common/constant/string_res.dart';
import 'package:userintegration_sqflite/pages/register_page/register.dart';
// import 'package:userintegration_sqflite/pages/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringResources.Title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: ColorResource.BlueGrey.withOpacity(0.5)),
      home: Register(),
    );
  }
}
