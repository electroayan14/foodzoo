import 'package:flutter/material.dart';
import 'package:foodzoo/features/dashboard/dashboard_screen.dart';
import 'package:foodzoo/features/location/location_screen.dart';
import 'package:foodzoo/features/screens/login/login_screen.dart';
import 'package:foodzoo/features/screens/otp/otp_screen.dart';
import 'package:foodzoo/features/screens/splash/splash_screen.dart';
import '../features/screens/cart/cart_screen.dart';
import '../features/screens/introduction/introduction.dart';
import '../features/screens/meals/meals_screens.dart';
import 'constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;
    switch (settings.name) {
      case homeRoute:
        return pageRouteBuilder(const SplashScreen());
      case introduction:
        return pageRouteBuilder(SilderScreen());
      case login:
        return pageRouteBuilder(LoginScreen());
      case otpScreen:
        return pageRouteBuilder(OTPScreen());
      case locationScreen:
        return pageRouteBuilder(const LocationScreen());
      case dashboardScreen:
        return pageRouteBuilder(const DashboardScreen());
      case meals:
        return pageRouteBuilder(MealsScreen(categoryName: args as String));
      case cart:
        return pageRouteBuilder(const CartView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

PageRouteBuilder pageRouteBuilder(screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      const begin = Offset(2.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
  );
}
