import 'package:flutter/material.dart';
import 'package:userintegration_sqflite/common/constant/color_res.dart';

// ignore: must_be_immutable
class CommonTextFormField extends StatelessWidget {
  Key key;
  TextEditingController controller;
  bool obscureText;
  FormFieldValidator validator;
  String hintText;
  Color color;
  bool readOnly;
  GestureTapCallback onTap;
  FormFieldSetter<String> onSaved;
  ValueChanged<String> onChanged;
  IconData icon;
  IconData icons;
  String initialValue;

  CommonTextFormField({
    this.key,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.hintText,
    this.color,
    this.icon,
    this.icons,
    this.onTap,
    this.onSaved,
    this.readOnly,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      onSaved: onSaved,
      initialValue: initialValue,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.start,
      readOnly: readOnly,
      style: TextStyle(
        fontSize: 18,
        color: ColorResource.White,
        wordSpacing: 1,
        letterSpacing: 1,
      ),
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(icon, color: ColorResource.Grey),
        labelText: hintText,
        labelStyle: TextStyle(
          color: ColorResource.Grey,
          fontSize: 15,
          wordSpacing: 2,
          letterSpacing: 1,
          height: 3,
        ),
        suffixIcon: Icon(icons, color: ColorResource.Grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color ?? ColorResource.White),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color ?? ColorResource.White),
        ),
      ),
    );
  }
}
