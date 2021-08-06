import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  static const String routeName = '/notifications';
  const NotificationsScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => NotificationsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Notifications'),
      ),
    );
  }
}
