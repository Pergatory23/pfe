import 'package:dashboard/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/assets.dart';
import 'dashboard_screen.dart';
import 'widgets/menu_button.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = '/menu';

  const MenuScreen({super.key});

  _resolveNavigation(String menuButton, BuildContext context) {
    switch (menuButton) {
      case 'Vente':
        return Get.toNamed(DashboardScreen.routeName);
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Transform.rotate(
            angle: 1.8,
            origin: const Offset(20, 40),
            child: Container(
              margin: const EdgeInsets.only(left: 50, top: 30),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors: [secondaryLighterColor, secondaryColor],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30).copyWith(top: GetPlatform.isMobile ? 70 : 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Modules ERP',
                      style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Choisissez le module à explorer',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30,
                      childAspectRatio: 1.1,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: List.generate(
                        menuButtons.length,
                        (index) => MenuButton(
                          image: menuButtons[index]['image'],
                          text: menuButtons[index]['name'],
                          color: Color(menuButtons[index]['color']),
                          onTap: () => _resolveNavigation(menuButtons[index]['name'], context),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> menuButtons = [
  {'name': 'Achat', 'image': Assets.iconAchat, 'color': 0xFF47B4FF},
  {'name': 'Stock', 'image': Assets.iconStock, 'color': 0xFFA885FF},
  {'name': 'Vente', 'image': Assets.iconVente, 'color': 0xFFFD47DF},
  {'name': 'Ressources Humaine', 'image': Assets.iconRH, 'color': 0xFFFD8C44},
  {'name': 'Production', 'image': Assets.iconProduction, 'color': 0xFF7DA4FF},
  {'name': 'Project', 'image': Assets.iconProjet, 'color': 0xFF43DC64},
  {'name': 'Finance', 'image': Assets.iconFinance, 'color': 0xffFD8BAB},
  {'name': 'Maintenance', 'image': Assets.iconMaintenance, 'color': 0xFFFD44C4},
  {'name': 'Comptabilité', 'image': Assets.iconComptabilite, 'color': 0xFF9862A3},
  {'name': 'Mobile', 'image': Assets.iconMobile, 'color': 0xFF397345},
];
