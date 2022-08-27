import 'package:flutter/material.dart';
import 'package:meggycakes/Widgets/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static const String routeName = "/otp";
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => OtpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Body(),
    );
  }
}
