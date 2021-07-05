import 'package:flutter/material.dart';
import 'package:userintegration_sqflite/common/constant/color_res.dart';

showLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(ColorResource.Orange),
                strokeWidth: 5,
                backgroundColor: ColorResource.White,
              ),
            )
          ],
        ),
      );
    },
  );
}

hideLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: false).pop();
}
