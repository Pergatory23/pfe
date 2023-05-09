import 'package:dashboard/menu.dart';
import 'package:flutter/material.dart';
void main() => runApp(DashboardHomePage());

class DashboardHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Color(0xFF363567),
      bottomNavigationBar: Container(height: 80,
      width: double.infinity,
      padding:EdgeInsets.all(10),
      color:Color(0xFF373856),
      child:Padding(
        padding: const EdgeInsets.only(bottom: 10),
        
        
        ),
      ),
  
   body: SingleChildScrollView(
        child: Column(
    children: [
      Stack(children: [
        Transform.rotate(angle:1.8,
        origin: Offset(20,40),
        child:Container(
          margin: EdgeInsets.only(
            left:50,
            top:30,
            ),
            height:400,
            width: double.infinity,
            decoration: BoxDecoration
            (borderRadius:BorderRadius.circular(80),
            gradient: LinearGradient(begin: Alignment.bottomLeft,
            colors: [Color(0xffFD8BAB),Color(0xFFFD44C4)],
            ), 
            ),
            ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal:20,vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('Bienvenue dans votre tableau de bord!',
          style:TextStyle(color:Colors.white,fontSize: 26,
          fontWeight:FontWeight.bold) ,
          ),
          SizedBox(
            height: 10,
            ),
          Text('Ici, vous pouvez voir un aperçu de vos données et gérer les fonctionnalités de votre application.',
          style:TextStyle(color:Colors.white,fontSize: 18,
          ) ,
          ),
          SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Menu()),
                );
                // Do something when the button is pressed
              },
              child: Text('commencer'),
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFD44C4)),
  ),

            )
          ],
          ),
          ),
        ],
        ),
        
      ],
      ),

  ),
    );
  }}