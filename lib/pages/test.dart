import 'package:flutter/material.dart';
import 'package:userintegration_sqflite/common/constant/color_res.dart';
import 'package:userintegration_sqflite/common/constant/string_res.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(StringResources.Title),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            TextFormField(
              key: Key('firstName'),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                suffixIcon: Icon(
                  Icons.supervised_user_circle,
                  color: ColorResource.Grey,
                ),
              ),
            ),
            TextFormField(
              key: Key('EmailAddress'),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                suffixIcon: Icon(
                  Icons.email,
                  color: ColorResource.Grey,
                ),
              ),
            ),
            RaisedButton(
                key: Key('RegistrationKey'),
                child: Text('LogIn'),
                onPressed: () {
                  print('Print From UI');
                }),
          ],
        ),
      ),
    );
  }
}
