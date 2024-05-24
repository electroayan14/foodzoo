import 'package:flutter/material.dart';

import '../../../utils/image_constants.dart';

Widget splashWidget() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Image.asset(ImageConstant.splashImage),
    ),
  );
}
