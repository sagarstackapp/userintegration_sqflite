import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CommonElevatedButton extends StatelessWidget {
  Key key;
  String text;
  Color textColor;
  Color buttonColor;
  VoidCallback onPressed;

  CommonElevatedButton({
    this.key,
    this.text,
    this.textColor,
    this.buttonColor,
    this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        key: key,
        onPressed: onPressed,
        child: Text(
          text ?? 'Enter Name',
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            buttonColor,
          ),
        ),
      ),
    );
  }
}
