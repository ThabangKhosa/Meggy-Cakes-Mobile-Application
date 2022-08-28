// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meggycakes/Widgets/navigation_drawer_widget.dart';
import 'package:meggycakes/screens/contact/body.dart';
import '../../Widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class ContactScreen extends StatelessWidget {
  static const String routeName = '/contact';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => ContactScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: CustomAppBar(
        title: 'Contact',
        automaticallyImplyLeading: false,
      ),
      body: ContactShow(),
      bottomNavigationBar: CustomNavBar(screen: routeName),
    );
  }
}
