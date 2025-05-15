/* import 'package:brain_rivals/constant.dart';

import 'package:brain_rivals/screens/offline_game/offline_game_screen.dart';
import 'package:brain_rivals/screens/online_game/online_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_repository/user_repository.dart';
class DetailPageOnline extends StatelessWidget {
  final String text;
  
  final String categoryName;
  final IconData icon;
  final String imageUrl;
  final MyUser? friend;

  const DetailPageOnline({
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
  MaterialPageRoute(builder: (context) =>  OnlineGameScreen(
    text:text,
    categoryName:categoryName,
    icon:icon,
    friend: friend,

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

import 'package:brain_rivals/screens/online_game/online_game_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

class DetailPageOnline extends StatefulWidget {
  final String text;
  final String categoryName;
  final IconData icon;
  final String imageUrl;
  final MyUser? friend;

  const DetailPageOnline({
    super.key,
    required this.icon,
    required this.text,
    required this.imageUrl,
    required this.categoryName,
    this.friend,
  });

  @override
  _DetailPageOnlineState createState() => _DetailPageOnlineState();
}

class _DetailPageOnlineState extends State<DetailPageOnline> {
  late final String? _currentUserId;
  late final FirebaseUserRepository userRepo;

  @override
  void initState() {
    super.initState();

    // FirebaseAuth'ten current user ID alınıyor
    _currentUserId = FirebaseAuth.instance.currentUser?.uid;

    // UserRepository örneği oluşturuluyor ve instance değişkene atılıyor
    userRepo = FirebaseUserRepository();
  }

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
            Image.asset("assets/images/gaga.png", height: 200),
            const SizedBox(height: 40),
            Text(
              "${widget.text} kategorisi",
              style: const TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 84, 78, 78),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: kPrimaryColor,
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
              ),
              onPressed: () async {
                if (_currentUserId == null || widget.friend == null) return;
                // Challenge oluştur
                final challengeID = await userRepo.createChallenge(
                  _currentUserId,
                  widget.friend!.id,
                  widget.categoryName,
                  widget.icon
                );
                
                // Oyun ekranına geçiş
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnlineGameScreen(
                      challengeID: challengeID,
          isChallenger: true,
          
         

                      text: widget.text,
                      categoryName: widget.categoryName,
                      icon: widget.icon,
                      friend: widget.friend,
                      
                    ),
                  ),
                );
              },
              child: const Text(
                "Oyuna Başla",
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
