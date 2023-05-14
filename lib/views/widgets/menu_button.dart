import 'package:flutter/material.dart';

import '../../helpers/colors.dart';

class MenuButton extends StatelessWidget {
  final String image;
  final String text;
  final Color color;
  final void Function()? onTap;

  const MenuButton({super.key, required this.image, required this.text, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: menuButtonColor),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image, width: 80, height: 80),
              const SizedBox(height: 10),
              Text(text, textAlign: TextAlign.center, style: TextStyle(color: color, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
