import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meggycakes/Widgets/size_config.dart';
import 'package:meggycakes/screens/splash2/components/body.dart';

class SplashScreenOne extends StatelessWidget {
  static const String routeName = "/splashOne";
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => SplashScreenOne());
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
