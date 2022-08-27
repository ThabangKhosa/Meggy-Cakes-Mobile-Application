// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:meggycakes/Widgets/size_config.dart';
import 'package:meggycakes/components/default_button.dart';
import 'package:meggycakes/screens/home/home_screen.dart';

class DeliveryShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage('assets/images/8.gif'))),
        ),
        Text(
          'Oops!! Looks like your delivery is empty',
          textAlign: TextAlign.center,
          // ignore: deprecated_member_use
          style: TextStyle(
              // ignore: deprecated_member_use
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        // ignore: prefer_const_constructors
        Text(
          'Please place an order in order to track your cake = )',
          textAlign: TextAlign.center,
          // ignore: deprecated_member_use
          style: TextStyle(
              // ignore: deprecated_member_use
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Order something",
            press: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
