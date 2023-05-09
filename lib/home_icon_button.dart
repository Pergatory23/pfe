
import 'package:dashboard/home.dart';
import 'package:flutter/material.dart';
class CategoryW extends StatelessWidget {
 String image;
 String text;
  Color color;
  CategoryW({super.key, required this.image,required this.text,required this.color});
 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0x9F3D416E),
                      ),
                      child: Column(
                        children: [
                        Image.asset(
                        image,
                        width:80,
                        height: 80,
                        ),
                        SizedBox(
                          height: 10,
                          ),
                          Text(text,
                          style:TextStyle(
                            color:color,
                            fontSize: 18),
                          )
                      ],
                      ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (
              context) => DashboardScreen()));
      },
    );
  }
}