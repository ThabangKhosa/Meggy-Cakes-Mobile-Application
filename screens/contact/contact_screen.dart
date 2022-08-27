// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
      appBar: CustomAppBar(title: 'Contact'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
    );
  }
}
