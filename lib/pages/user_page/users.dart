import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:userintegration_sqflite/common/constant/string_res.dart';
import 'package:userintegration_sqflite/common/widget/widget.dart';
import 'package:userintegration_sqflite/model/usermodel.dart';
import 'package:userintegration_sqflite/pages/register_page/register.dart';
import 'package:userintegration_sqflite/service/db_helper.dart';

// ignore: must_be_immutable
class UsersList extends StatefulWidget {
  Function onChanged;

  UsersList({this.onChanged});

  @override
  UsersListState createState() => UsersListState();
}

class UsersListState extends State<UsersList> {
  final TextEditingController searchController = TextEditingController();
  Future<List<UserModel>> _userList;
  List searchUserList = [];
  CommonWidget commonWidget = CommonWidget();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    setState(() {
      _userList = DBHelper.instance.getAllUserList();
    });
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
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            searchByName(),
            searchController.text.trim().length == 0
                ? userData()
                : searchResult(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
        },
      ),
    );
  }

  void searchUserByName(userName) async {
    final allRows = await DBHelper.instance.searchUser(userName);
    searchUserList.clear();
    allRows.forEach((element) {
      searchUserList.add(UserModel.fromMap(element));
    });
  }

  searchByName() {
    return Container(
      width: double.infinity,
      child: commonWidget.search(
        searchController,
        (userName) {
          print('Current searched name : $userName');
          if (userName.toString().length >= 1) {
            setState(() {
              searchUserByName(userName);
            });
          } else {
            setState(() {
              searchUserList.clear();
            });
          }
        },
      ),
    );
  }

  userData() {
    return FutureBuilder(
      future: _userList,
      builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  shrinkWrap: true,
                  primary: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return commonWidget.userDetails(
                        snapshot.data[index], context);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(thickness: 3);
                  },
                  itemCount: snapshot.data.length,
                ),
              );
      },
    );
  }

  searchResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: searchUserList.length,
        itemBuilder: (BuildContext context, int index) {
          var data = searchUserList[index];
          return commonWidget.searchUser(
            data.userName,
            data.email,
            data.address,
          );
        },
      ),
    );
  }
}
