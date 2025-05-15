import 'package:brain_rivals/screens/online_game/history_screen.dart';
import 'package:brain_rivals/screens/online_game/invite_firend_screen.dart';
import 'package:flutter/material.dart';

class OnlineGameInvitePage extends StatelessWidget {
  const OnlineGameInvitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Çevrim İçi Oyun',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/arkaplan01.jpg',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Büyük logo
                  Center(
                    child: Image.asset(
                      "assets/images/BrainRivals4545.png",
                      height: 320,
                    ),
                  ),
                  const SizedBox(height: 40),

                                    GestureDetector(
                    onTap: () {
                      Navigator.push(
                 context,
                  MaterialPageRoute(builder: (context) {
                    return  const InviteFriendScreen(); // Profil seçme ekranına yönlendirme
                  }),
                ); 
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurpleAccent.withOpacity(0.9),
                            Colors.purpleAccent.withOpacity(0.9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Arkadaşına Meydan Oku',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox( height: 20,),
                  // Geçmiş Container
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>  HistoryScreen(),
      ),
    );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Geçmiş/Davetler',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Arkadaşını meydan oku Container

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
