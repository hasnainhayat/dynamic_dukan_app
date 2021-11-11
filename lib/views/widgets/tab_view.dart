import 'package:dynamic_dukan/views/screens/auth/login_screen.dart';
import 'package:dynamic_dukan/views/screens/vendor/vendor_home_screen.dart';
import 'package:flutter/material.dart';

class AuthTab extends StatelessWidget {
  const AuthTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(children: [
            TabBar(tabs: <Widget>[
              Tab(
                text: 'Login',
              ),
              Tab(
                text: 'Register',
              ),
            ]),
            TabBarView(children: [
              LoginScreen(),
              VendorHomeScreen(),
            ])
          ]),
        ));
  }
}
