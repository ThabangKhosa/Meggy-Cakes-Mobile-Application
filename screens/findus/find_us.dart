// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meggycakes/Widgets/navigation_drawer_widget.dart';
import 'package:meggycakes/screens/findus/body.dart';
import '../../Widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class FindUsScreen extends StatelessWidget {
  static const String routeName = '/findus';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => FindUsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: CustomAppBar(
        title: 'Find Us',
        automaticallyImplyLeading: false,
      ),
      body: FindUs(),
      bottomNavigationBar: CustomNavBar(screen: routeName),
    );
  }
}
