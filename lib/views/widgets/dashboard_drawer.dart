import 'package:dashboard/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen.dart';

List<String> menuItems = ['Menu', 'Logout'];

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  Icon _resoveIcon(String item) {
    switch (item) {
      case 'Menu':
        return const Icon(Icons.widgets);
      case 'Logout':
        return const Icon(Icons.logout);
      default:
        // TODO: gérer les autres cas
        return const Icon(Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: Center(
                child: Text(
                  'Dashboard Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            for (var item in menuItems)
              ListTile(
                title: Text(item),
                leading: _resoveIcon(item),
                onTap: () {
                  Get.back();
                  switch (item) {
                    case 'Menu':
                      // When on DashboardScreen the previous screen on the stack will be MenuScreen
                      Future.delayed(const Duration(milliseconds: 300), () => Get.back());
                      break;
                    case 'Logout':
                      Get.toNamed(HomeScreen.routeName);
                      break;
                    default:
                      // TODO: gérer les autres cas
                      break;
                  }
                },
              ),
          ],
        ),
      );
}
