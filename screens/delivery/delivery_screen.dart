// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meggycakes/Widgets/navigation_drawer_widget.dart';
import 'package:meggycakes/screens/delivery/body.dart';
import '../../Widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class DeliveryScreen extends StatelessWidget {
  static const String routeName = '/delivery';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => DeliveryScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: CustomAppBar(
        title: 'Delivery',
        automaticallyImplyLeading: false,
      ),
      body: DeliveryShow(),
      bottomNavigationBar: CustomNavBar(screen: routeName),
    );
  }
}
