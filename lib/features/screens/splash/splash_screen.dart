import 'package:flutter/material.dart';
import 'package:foodzoo/features/screens/splash/widgets/splash_widgets.dart';

import '../../../routes/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(introduction, (Route<dynamic> route) => false);
    });
    return splashWidget();
  }
}
