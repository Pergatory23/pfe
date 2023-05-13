import 'package:dashboard/controllers/dashboard_controller.dart';
import 'package:dashboard/services/database_meta_service.dart';
import 'package:dashboard/views/dashboard_screen.dart';
import 'package:dashboard/views/filter_screen.dart';
import 'package:dashboard/views/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/filter_controller.dart';
import 'services/shared_preferences.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      initialBinding: InitialBindings(),
      initialRoute: HomeScreen.routeName,
      getPages: [
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: MenuScreen.routeName,
          page: () => const MenuScreen(),
        ),
        GetPage(
          name: DashboardScreen.routeName,
          page: () => const DashboardScreen(),
          binding: BindingsBuilder.put(() => DashboardController()),
        ),
        GetPage(
          name: FilterScreen.routeName,
          page: () => const FilterScreen(),
          binding: BindingsBuilder.put(() => FilterController()),
        ),
      ],
    );
  }
}

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // Getx dependencies
    Get.put<SharedPreferencesService>(SharedPreferencesService(), permanent: true);
    Get.put<DatabaseMetaService>(DatabaseMetaService(), permanent: true);
  }
}
