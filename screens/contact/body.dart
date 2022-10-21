// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_local_variable, prefer_const_declarations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:meggycakes/Widgets/size_config.dart';
import 'package:meggycakes/components/default_button.dart';
import 'package:meggycakes/screens/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactShow extends StatelessWidget {
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
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/contact.png'))),
        ),
        Spacer(),
        Text(
          'Contact us any time if you have a query',
          textAlign: TextAlign.center,
          // ignore: deprecated_member_use
          style: TextStyle(
              // ignore: deprecated_member_use
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        // ignore: prefer_const_constructors
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Get Directions",
            press: () async {
              final url = "https://goo.gl/maps/zNAnZcVgL1xqXUFx5";

              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Email Us",
            press: () async {
              String email = 'abelisaack1@gmail.com';
              String subject = 'Regarding Cakes';
              String message = '';
              final url =
                  'mailto:$email?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
