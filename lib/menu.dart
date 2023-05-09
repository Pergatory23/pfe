import 'package:dashboard/home_icon_button.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        home: Menu1(),
    );
  }
}

class Menu1 extends StatelessWidget {
  const Menu1({super.key});
  
void _openNewScreen(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(child: Text('This is the $title screen')),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFF363567),
    bottomNavigationBar: Container(
      height: 80,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      color: Color(0xFF373856),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () => _openNewScreen(context, 'Achat'),
                child: Image.asset(
                  'images/achat.png',
                  height: 40,
                  width: 40,
                ),),

            Image.asset('images/stock.png',
            height:40,
            width:40,),

            Image.asset('images/vente.png',
            height:40,
            width:40,),

            Image.asset('images/rh.png',
            height:40,
            width:40,),

            Image.asset('images/production.png',
            height:40,
            width:40,),

            Image.asset('images/projet.png',
            height:40,
            width:40,),

            Image.asset('images/finance.png',
            height:40,
            width:40,),

            Image.asset('images/maintenance.png',
            height:40,
            width:40,),

            Image.asset('images/comptabilité.png',
            height:40,
            width:40,),

            Image.asset('images/mobile.png',
            height:40,
            width:40,
            ),

        ],
        ),
      ),
  ),),

  body:SingleChildScrollView(
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
            height:300,
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
          Text('Modules ERP',
          style:TextStyle(color:Colors.white,fontSize: 26,
          fontWeight:FontWeight.bold) ,
          ),
          SizedBox(
            height: 10,
            ),
          Text('Choisissez le module à explorer',
          style:TextStyle(color:Colors.white,fontSize: 18,
          ) ,
          ),
          Padding(
            padding: EdgeInsets.only(top:20),
          child:Column(
            children: [
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                children: [
                CategoryW(image: 'images/achat.png', 
                text: 'Achat', 
                color: Color(0xFF47B4FF),
                ),

                 CategoryW(image: 'images/stock.png', 
                text: 'Stock', 
                color: Color(0xFFA885FF),
                ),

              ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                children: [
                CategoryW(image: 'images/vente.png', 
                text: 'Vente', 
                color: Color(0xFFFD47DF),
                ),

                 CategoryW(image: 'images/rh.png', 
                text: 'Ressources Humaine', 
                color: Color(0xFFFD8C44),
                ),

              ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                children: [
                CategoryW(image: 'images/production.png', 
                text: 'Production', 
                color: Color(0xFF7DA4FF),
                ),

                 CategoryW(image: 'images/projet.png', 
                text: 'Projet', 
                color: Color(0xFF43DC64),
                ),

              ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                children: [
                CategoryW(image: 'images/finance.png', 
                text: 'Finance', 
                color: Color(0xffFD8BAB),
                ),

                 CategoryW(image: 'images/maintenance.png', 
                text: 'Maintenance', 
                color: Color(0xFFFD44C4),
                ),

              ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                children: [
                CategoryW(image: 'images/comptabilité.png', 
                text: 'Comptabilité', 
                color: Color.fromARGB(255, 152, 98, 163),
                ),

                 CategoryW(image: 'images/mobile.png', 
                text: 'Mobile', 
                color: Color.fromARGB(252, 7, 65, 19),
                ),

              ],
              ),
              SizedBox(height: 10,),
          ],
          ),
          ),
        ],
        ),
        ),
      ],
      ),

  ],
  ),
  ));
  }
}