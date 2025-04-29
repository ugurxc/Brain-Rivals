import 'package:brain_rivals/constant.dart';
import 'package:brain_rivals/screens/friend_screen.dart';
import 'package:brain_rivals/screens/nofit_screen.dart';

import 'package:brain_rivals/screens/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final userRepository = FirebaseUserRepository();
    return  Scaffold(
      backgroundColor: kPrimaryColor,
    /*   appBar: AppBar(
        
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.chevron_left_outlined , size: 32, color: Colors.white,)),
        backgroundColor: Colors.transparent,
        
        title: const Text('Sosyal', style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)  ,),
       
      ), */
      body: Container(
        decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/arkaplan01.jpg'), // Arka plan resmi
              fit: BoxFit.cover, // Resmin tüm alanı kaplaması
            )),
        child: Column(
          children: [
            Container(
              
              child: SizedBox(
                height: 100, 
                width: MediaQuery.of(context).size.width,
                child: Row(
                  
                  children: [
                    IconButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, icon: const Icon(Icons.chevron_left_outlined , size: 32, color: Colors.white,)),
                        SizedBox(width: MediaQuery.of(context).size.width/4,),
                        const Text('Sosyal', style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold  ,fontSize: 32 , ))
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10,),
             SizedBox(
                    height: 300,
                    width: 300,
                    child: Image.asset(
                      "assets/images/gaga.png",
                    )),
                const SizedBox(
                  height: 0,
                ),
        
            const SizedBox(height: 40,),
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                          showSearch(
                  context: context,
                  delegate: UserSearchDelegate([],userRepository), // Boş bir kullanıcı listesi başlangıç için
                );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                // Çerçevenin arka plan rengi
                                border: Border.all(
                                  color: kPrimaryLightColor, // Çerçeve rengi
                                  width: 5, // Çerçeve kalınlığı
                                ),
                                borderRadius: BorderRadius.circular(15), // Yuvarlak köşe
                              ),
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/images/search2.jpg",
                                  ))),
                        ),
                        const Text(
                          "Kullanıcı Arama",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const FriendsScreen()),
);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                // Çerçevenin arka plan rengi
                                border: Border.all(
                                  color: kPrimaryLightColor, // Çerçeve rengi
                                  width: 5, // Çerçeve kalınlığı
                                ),
                                borderRadius: BorderRadius.circular(15), // Yuvarlak köşe
                              ),
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/images/arkadaslar.jpg",
                                  ))),
                        ),
                        const Text(
                          "Arkadaşlar",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const NotificationsScreen()),
);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            // Çerçevenin arka plan rengi
                            border: Border.all(
                              color: kPrimaryLightColor, // Çerçeve rengi
                              width: 5, // Çerçeve kalınlığı
                            ),
                            borderRadius: BorderRadius.circular(15), // Yuvarlak köşe
                          ),
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/bildirim.png",
                              ))),
                    ),
                    const Text(
                      "Bildirimler",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
        
          
        
            ]),
      ));
  }
}