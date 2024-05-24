import 'package:flutter/material.dart';
import 'package:foodzoo/features/utils/image_constants.dart';

Future appAlertDialog(context, void Function()? onClick) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onClick,
                child: Image.asset(
                  ImageConstant.facebookLogo,
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        );
      });
}
