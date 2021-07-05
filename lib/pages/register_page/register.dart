import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:userintegration_sqflite/common/constant/color_res.dart';
import 'package:userintegration_sqflite/common/constant/string_res.dart';
import 'package:userintegration_sqflite/common/methods/methods.dart';

import 'package:userintegration_sqflite/common/widget/widget.dart';
import 'package:userintegration_sqflite/model/usermodel.dart';
import 'package:userintegration_sqflite/pages/user_page/users.dart';
import 'package:userintegration_sqflite/service/db_helper.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  UserModel userModel;

  Register({this.userModel});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int currentIndex = 0;
  CommonWidget commonWidget = CommonWidget();

  @override
  void initState() {
    if (widget.userModel != null) {
      print('Id : ${widget.userModel.id}');
      print('UserName : ${widget.userModel.userName}');
      print('UserEmail : ${widget.userModel.email}');
      print('UserAddress : ${widget.userModel.address}');
      print('UserDOB : ${widget.userModel.dob}');
      nameController.text = widget.userModel.userName.toString();
      emailController.text = widget.userModel.email.toString();
      dobController.text = widget.userModel.dob.toString();
      addressController.text = widget.userModel.address.toString();
      passwordController.text = widget.userModel.password.toString();
      cPasswordController.text = widget.userModel.password.toString();
    } else {
      setState(() {
        clearData();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(runtimeType);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(StringResources.Title),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          shrinkWrap: true,
          children: [
            commonWidget.firstName(nameController),
            commonWidget.email(emailController),
            commonWidget.birthDate(dobController, selectedDate, selectDate),
            commonWidget.address(addressController),
            commonWidget.password(passwordController),
            commonWidget.confirmPassword(
                cPasswordController, passwordController),
            SizedBox(height: 30),
            widget.userModel != null
                ? commonWidget.register('Update', registerUser)
                : commonWidget.register('Register', registerUser),
            SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UsersList()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.supervised_user_circle),
        ),
      ),

    );
  }

  void selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var _dob = selectedDate.toString().split(' ')[0];
        dobController.text = _dob;
      });
  }

  registerUser() {
    final isValid = formKey.currentState.validate();

    if (isValid) {
      formKey.currentState.save();
      print(
          'Name :${nameController.text}\nEmail :${emailController.text}\nDOB :${dobController.text}\nAddress :${addressController.text}\nPassword :${passwordController.text}');
      showLoader(context);
      UserModel userModel = UserModel(
        userName: nameController.text,
        dob: dobController.text,
        password: passwordController.text,
        address: addressController.text,
        email: emailController.text,
      );
      if (widget.userModel != null) {
        print('Update method Called.!');
        userModel.id = widget.userModel.id;
        DBHelper.instance.updateUser(userModel);
        clearData();
        setState(() {});
      } else {
        print('Insert method Called.!');
        DBHelper.instance.addUser(userModel);
        clearData();
        setState(() {});
      }
      Fluttertoast.showToast(
        msg: 'Saved Data.!',
        backgroundColor: ColorResource.Orange,
        textColor: ColorResource.White,
      );
      hideLoader(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UsersList()));
    }
  }

  clearData() {
    nameController.clear();
    dobController.clear();
    passwordController.clear();
    cPasswordController.clear();
    addressController.clear();
    emailController.clear();
  }
}
