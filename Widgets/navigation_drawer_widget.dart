// ignore: unnecessary_import
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_declarations

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meggycakes/Widgets/user_page.dart';
import 'package:meggycakes/screens/home/home_screen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = 'Kyle Cena';
    final email = 'kyle@gmail.com';
    final urlImage =
        'https://images.unsplash.com/photo-1550332781-aecd27f7434f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';
    return Drawer(
      child: Material(
          color: Color.fromARGB(255, 26, 23, 15),
          child: ListView(
            padding: padding,
            children: <Widget>[
              buildHeader(
                  urlImage: urlImage,
                  name: name,
                  email: email,
                  onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserPage(
                            name: name,
                            urlImage: urlImage,
                          )))),
              const SizedBox(height: 48),
              buildMenuItem(
                text: 'Homepage',
                icon: Icons.home,
                onClicked: () => selectedItem(context, 0),
              ),
              const SizedBox(height: 16),
              buildMenuItem(
                text: 'Contact',
                icon: Icons.mail,
                onClicked: () => selectedItem(context, 2),
              ),
              const SizedBox(height: 16),
              buildMenuItem(
                text: 'Cart',
                icon: Icons.notifications,
                onClicked: () => selectedItem(context, 4),
              ),
              const SizedBox(height: 16),
              buildMenuItem(
                text: 'Delivery',
                icon: Icons.delivery_dining,
                onClicked: () => selectedItem(context, 6),
              ),
              const SizedBox(height: 16),
              buildMenuItem(
                text: 'Log Out',
                icon: Icons.logout_outlined,
                onClicked: () => selectedItem(context, 7),
              ),
            ],
          )),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
            padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 25, backgroundImage: NetworkImage(urlImage)),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                )
              ],
            )),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.black38;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color, fontSize: 15)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 2:
        Navigator.pushNamed(context, '/contact');
        break;
      case 4:
        Navigator.pushNamed(context, '/cart');
        break;
      case 5:
        Navigator.pushNamed(context, '/profile');
        break;
      case 6:
        Navigator.pushNamed(context, '/delivery');
        break;
      case 7:
        Navigator.pushNamed(context, '/home');
        break;
    }
  }
}
