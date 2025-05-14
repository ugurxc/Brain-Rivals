/* import 'package:brain_rivals/constant.dart';

import 'package:brain_rivals/screens/offline_game/offline_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_repository/user_repository.dart';
class DetailPage extends StatelessWidget {
  final String text;
  
  final String categoryName;
  final IconData icon;
  final String imageUrl;
  final MyUser? friend;

  const DetailPage({
    super.key,
    required this.icon,
    required this.text,
    required this.imageUrl,
    required this.categoryName, this.friend
    
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 254, 218),
      ),
      backgroundColor: const Color.fromARGB(255, 234, 254, 218),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

           
            Image.asset("assets/images/gaga.png" , height: 200,),

            const SizedBox(height: 40,),
            Text(
              "$text kategorisi ",
              style: const TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 84, 78, 78),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
                        Container(
              decoration: BoxDecoration(
                // Çerçevenin arka plan rengi
                border: Border.all(
                  color: kPrimaryColor, // Çerçeve rengi
                  width: 5, // Çerçeve kalınlığı
                ),
                borderRadius: BorderRadius.circular(15), // Yuvarlak köşe
              ),
             
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(kPrimaryColor)
              ),
              onPressed: () {
              Navigator.push(
  context,
  MaterialPageRoute(builder: (context) =>  OfflineGameScreen(
    text:text,
    categoryName:categoryName,
    icon:icon,
    

  )),
);
            }, child: const Text("Oyuna Başla" , style: TextStyle(fontSize: 32 , color: Colors.white),))
          ],
        ),
      ),
    );
  }
}
 */

import 'package:brain_rivals/constant.dart';
import 'package:brain_rivals/screens/offline_game/offline_game_screen.dart';


import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String text;
  
  final String categoryName;
  final IconData icon;
  final String imageUrl;

  const DetailPage({
    super.key,
    required this.icon,
    required this.text,
    required this.imageUrl,
    required this.categoryName
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 254, 218),
      ),
      backgroundColor: const Color.fromARGB(255, 234, 254, 218),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

           
            Image.asset("assets/images/gaga.png" , height: 200,),

            const SizedBox(height: 40,),
            Text(
              "$text kategorisi",
              style: const TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 84, 78, 78),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
                        Container(
              decoration: BoxDecoration(
                // Çerçevenin arka plan rengi
                border: Border.all(
                  color: kPrimaryColor, // Çerçeve rengi
                  width: 5, // Çerçeve kalınlığı
                ),
                borderRadius: BorderRadius.circular(15), // Yuvarlak köşe
              ),
             
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(kPrimaryColor)
              ),
              onPressed: () {
              Navigator.push(
  context,
  MaterialPageRoute(builder: (context) =>  OfflineGameScreen(
    text:text,
    categoryName:categoryName,
    icon:icon

  )),
);
            }, child: const Text("Oyuna Başla" , style: TextStyle(fontSize: 32 , color: Colors.white),))
          ],
        ),
      ),
    );
  }
}