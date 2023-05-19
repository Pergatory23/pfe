import 'package:dashboard/helpers/colors.dart';
import 'package:dashboard/views/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Transform.rotate(
                  angle: 1.8,
                  origin: const Offset(20, 40),
                  child: Container(
                    margin: const EdgeInsets.only(left: 50, top: 30),
                    height: 400,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (GetPlatform.isMobile) SizedBox(height: size.height * 0.3),
                      const Text(
                        'Bienvenue dans votre tableau de bord!',
                        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Ici, vous pouvez voir un aperçu de vos données et gérer les fonctionnalités de votre application.',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 50),
                      Align(
                        alignment: GetPlatform.isMobile ? Alignment.center : Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () => Get.toNamed(MenuScreen.routeName),
                          style:
                              ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(secondaryColor), minimumSize: const MaterialStatePropertyAll(Size(200, 50))),
                          child: const Text('commencer'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
