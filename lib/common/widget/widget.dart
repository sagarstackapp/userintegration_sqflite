import 'package:flutter/material.dart';
import 'package:userintegration_sqflite/common/constant/color_res.dart';
import 'package:userintegration_sqflite/common/widget/elevated_button.dart';
import 'package:userintegration_sqflite/common/widget/text_form_field.dart';
import 'package:userintegration_sqflite/model/usermodel.dart';
import 'package:userintegration_sqflite/pages/register_page/register.dart';
import 'package:userintegration_sqflite/service/db_helper.dart';

class CommonWidget {
  Widget firstName(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CommonTextFormField(
        // valueKey: 'firstName',
        controller: controller,
        hintText: 'Enter Firstname',
        readOnly: false,
        icon: Icons.supervised_user_circle,
        validator: (value) {
          if (value.trim().isEmpty) {
            return 'First name can\'t be empty!';
          }
          if (!RegExp(r"^[a-zA-Z]+").hasMatch(value)) {
            return 'Enter a valid first name.!';
          }
          return null;
        },
      ),
    );
  }

  Widget email(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CommonTextFormField(
        // valueKey: 'EmailAddress',
        controller: controller,
        hintText: 'Enter Email Address',
        icon: Icons.email,
        readOnly: false,
        validator: (value) {
          if (value.isEmpty) {
            return 'Email address can\'t be empty!';
          }
          if (!RegExp(
                  r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+")
              .hasMatch(value)) {
            return 'Enter a valid username.!';
          }
          return null;
        },
      ),
    );
  }

  Widget birthDate(TextEditingController controller, date, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CommonTextFormField(
        // key: Key('DOB'),
        controller: controller,
        onTap: onTap,
        readOnly: true,
        hintText: 'Date Of Birth',
        icon: Icons.calendar_today,
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a valid Date of Birth!';
          }
          return null;
        },
      ),
    );
  }

  Widget address(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CommonTextFormField(
        // key: Key('Address'),
        controller: controller,
        hintText: 'Enter Address',
        icon: Icons.home,
        readOnly: false,
        validator: (value) {
          if (value.isEmpty) {
            return 'Address can\'t be empty!';
          }
          return null;
        },
      ),
    );
  }

  Widget password(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CommonTextFormField(
        // key: Key('Password'),
        controller: controller,
        hintText: 'Enter password',
        icon: Icons.vpn_key,
        obscureText: true,
        readOnly: false,
        validator: (value) {
          if (value.isEmpty) {
            return 'Password can\'t be empty!';
          }
          if (controller.text.length < 8) {
            return 'Password must be 8 character long.!';
          }
          return null;
        },
      ),
    );
  }

  Widget confirmPassword(
      TextEditingController controller, TextEditingController controller1) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CommonTextFormField(
        // key: Key('ConfirmPassword'),
        controller: controller,
        hintText: 'Enter password again',
        obscureText: true,
        readOnly: false,
        icon: Icons.vpn_key,
        validator: (value) {
          if (value.isEmpty) {
            return 'Confirm password can\'t be empty!';
          }
          if (controller.text.length < 8) {
            return 'Confirm password must be 8 character long.!';
          }
          if (controller1.text != controller.text) {
            return 'Password do not matching.!';
          }
          return null;
        },
      ),
    );
  }

  Widget register(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CommonElevatedButton(
        key: Key('RegistrationKey'),
        text: text,
        buttonColor: ColorResource.White,
        textColor: ColorResource.Grey,
        onPressed: onPressed,
      ),
    );
  }

  Widget search(TextEditingController controller, onChanged) {
    return CommonTextFormField(
      // key: Key('Search'),
      controller: controller,
      hintText: 'Find user',
      readOnly: false,
      onChanged: onChanged,
      icon: Icons.verified_user_rounded,
    );
  }

  Widget userDetails(UserModel userModel, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                userModel.userName ?? 'NULL Name',
                style: TextStyle(
                  color: ColorResource.Black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResource.Grey,
                ),
                child: IconButton(
                  onPressed: () {
                    editProfile(userModel, context);
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                userModel.email ?? 'NULL Email',
                style: TextStyle(color: ColorResource.Grey),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResource.Red,
                ),
                child: IconButton(
                  onPressed: () {
                    deleteProfile(userModel.id);
                  },
                  icon: Icon(Icons.delete_forever),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            userModel.address ?? 'NULL Address',
            style: TextStyle(color: ColorResource.Grey),
            overflow: TextOverflow.fade,
          ),
        ],
      ),
    );
  }

  Widget searchUser(userName, userEmail, userAddress) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName ?? 'NULL Name',
          style: TextStyle(
            color: ColorResource.Black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10),
        Text(
          userEmail ?? 'NULL Email',
          style: TextStyle(color: ColorResource.Grey),
        ),
        SizedBox(height: 10),
        Text(
          userAddress ?? 'NULL Address',
          style: TextStyle(color: ColorResource.Grey),
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}

deleteProfile(id) {
  // var currentIndex = 0;
  print('Delete request for user with : $id');
  DBHelper.instance.deleteUser(id);
  // tabController.animateTo(currentIndex, curve: Curves.easeInCirc);
  print('Delete user for : $id');
}

editProfile(userModel, context) {
  // var currentIndex = 0;
  print('Edit request for userId : ${userModel.id}');
  print('Edit request for user : ${userModel.userName}');
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => Register(userModel: userModel)));
  // onChanged.call(userModel);
  // tabController.animateTo(currentIndex, curve: Curves.easeInCirc);
}
