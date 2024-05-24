import 'package:flutter/material.dart';
import 'package:foodzoo/features/utils/image_constants.dart';
import 'package:foodzoo/widgets/custom_textfield.dart';

import '../../../widgets/custom_button.dart';
import '../../utils/colors.dart';

Widget locationView(
    void Function()? onAllowLocation, textController, bool? showLoader) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Center(
              child: Image.asset(
            ImageConstant.locationLogo,
            width: 400,
            height: 400,
          )),
          const SizedBox(height: 8.0),
          Center(
              child: Text(
            textController,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          )),
          SizedBox(height: 8.0),
          const SizedBox(height: 8.0),
          showLoader == false
              ? CustomButton(
                  onPress: onAllowLocation,
                  enableButton: true,
                  backgroundColor: AppColors.appThemeColor,
                  height: 56.0,
                  isShowIcon: true,
                  src: ImageConstant.locationIcon,
                  buttonText: 'Allow Location',
                  textColor: Colors.black,
                )
              : Center(
                  child: CircularProgressIndicator(
                      color: AppColors.appThemeColor)),
        ],
      ),
    ),
  );
}
