import 'package:dashboard/views/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363567),
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        color: const Color(0xFF373856),
      ),
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
                        colors: [Color(0xffFD8BAB), Color(0xFFFD44C4)],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bienvenue dans votre tableau de bord!',
                        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Ici, vous pouvez voir un aperçu de vos données et gérer les fonctionnalités de votre application.',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Get.toNamed(MenuScreen.routeName),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFD44C4))),
                        child: const Text('commencer'),
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
