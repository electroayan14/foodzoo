import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodzoo/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:foodzoo/features/screens/login/bloc/login_bloc.dart';
import 'package:foodzoo/features/screens/login/login_screen.dart';
import 'package:foodzoo/features/screens/otp/bloc/otp_bloc.dart';
import 'package:foodzoo/routes/constants.dart';
import 'package:foodzoo/routes/foodzoo_routes.dart';

import 'features/screens/meals/bloc/meals_bloc.dart';
import 'features/screens/splash/splash_screen.dart';

class FoodZoo extends StatefulWidget {
  const FoodZoo({super.key});

  @override
  State<FoodZoo> createState() => _FoodZooState();
}

class _FoodZooState extends State<FoodZoo> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => OtpBloc(),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => MealsBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: homeRoute,
        theme: ThemeData(brightness: Brightness.light, useMaterial3: true),
      ),
    );
  }
}
