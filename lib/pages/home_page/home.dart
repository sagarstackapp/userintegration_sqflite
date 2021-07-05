import 'package:flutter/material.dart';
import 'package:userintegration_sqflite/common/constant/string_res.dart';
import 'package:userintegration_sqflite/model/usermodel.dart';
import 'package:userintegration_sqflite/pages/register_page/register.dart';
import 'package:userintegration_sqflite/pages/user_page/users.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

// TabController tabController;

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<Widget> tabs = [
    Tab(icon: Icon(Icons.supervisor_account), text: 'Register'),
    Tab(icon: Icon(Icons.supervised_user_circle_outlined), text: 'Active User'),
  ];
  int currentIndex = 0;
  UserModel userModel;
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: currentIndex,
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            title: Center(
              child: Text(StringResources.Title),
            ),
            bottom: TabBar(
              controller: tabController,
              tabs: tabs,
            ),
          ),
          preferredSize: Size(double.infinity, 110),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            Register(userModel: userModel),
            UsersList(onChanged: onChanged),
          ],
        ),
      ),
    );
  }

  onChanged(UserModel _userModel) {
    setState(() {
      userModel = _userModel;
      print('Model ID : ${_userModel.id}');
    });
  }
}
