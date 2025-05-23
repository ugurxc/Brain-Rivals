

import 'package:brain_rivals/screens/online_game/online_game_screen.dart';
import 'package:brain_rivals/screens/other_profile_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userRepo = Provider.of<UserRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meydan Okuma Geçmişi'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Challenge>>(
        stream: userRepo.getUserChallenges(currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          final challenges = snapshot.data ?? [];
          
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: challenges.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) => _ChallengeItem(
              challenge: challenges[index],
              currentUserID: currentUser.uid,
            ),
          );
        },
      ),
    );
  }
}

class _ChallengeItem extends StatelessWidget {
  final Challenge challenge;
  final String currentUserID;

  const _ChallengeItem({
    required this.challenge,
    required this.currentUserID,
  });

  @override
  Widget build(BuildContext context) {
    final isChallenger = challenge.challengerID == currentUserID;
    final opponentID = isChallenger ? challenge.challengedID : challenge.challengerID;
    final userRepo = Provider.of<UserRepository>(context, listen: false);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: challenge.status == 'completed' 
              ? Colors.green 
              : Colors.orange,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kategori ve Durum
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    challenge.category.substring(0, challenge.category.length - 2),
                    
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.deepPurple,
                ),
                _buildStatusIndicator(),
                
              ],
            ),
            const SizedBox(height: 12),

            // Rakip Bilgisi
            FutureBuilder<MyUser>(
              future: userRepo.getUser(opponentID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.grey),
                    title: Text('Yükleniyor...'),
                  );
                }
                
                final opponent = snapshot.data!;
                
                return ListTile(
                  leading: InkWell(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OtherProfilePage(user: opponent,);
            },));
                    },
                    child: CircleAvatar(
                      backgroundImage: opponent.picture != null
                          ? AssetImage(opponent.picture!)
                          : const AssetImage('assets/default_avatar.png') 
                              as ImageProvider,
                    ),
                  ),
                  title: Text(
                    opponent.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(opponent.email),
                );
              },
            ),
            const Divider(height: 24),

            // Skor Tablosu
            _ScoreRow(
              yourScore: isChallenger 
                  ? challenge.challengerScore 
                  : challenge.challengedScore,
              opponentScore: isChallenger 
                  ? challenge.challengedScore 
                  : challenge.challengerScore,
            ),
            const SizedBox(height: 16),

            // Aksiyon Butonu
            if (challenge.status != 'completed' && !isChallenger)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('MEYDAN OKUMAYA KATIL'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _navigateToChallenge(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
  Widget get _challengeTypeIndicator {
  final isChallenger = challenge.challengerID == currentUserID;
  
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: isChallenger ? Colors.blue[100] : Colors.purple[100],
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      isChallenger ? 'Başlattığın' : 'Gelen',
      style: TextStyle(
        color: isChallenger ? Colors.blue[800] : Colors.purple[800],
      ),
    ),
  );
}


  Widget _buildStatusIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: challenge.status == 'completed'
            ? Colors.green.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: challenge.status == 'completed' 
              ? Colors.green 
              : Colors.orange,
        ),
      ),
      child: Text(
        challenge.status == 'completed' ? 'TAMAMLANDI' : 'BEKLİYOR',
        style: TextStyle(
          color: challenge.status == 'completed' 
              ? Colors.green 
              : Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _navigateToChallenge(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OnlineGameScreen(
          icon: challenge.icon,
          text: challenge.category.substring(0, challenge.category.length - 2),
          
          challengeID: challenge.id,
          isChallenger: false,
          categoryName: challenge.category,
        ),
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  final int yourScore;
  final int opponentScore;

  const _ScoreRow({
    required this.yourScore,
    required this.opponentScore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildScoreColumn('SEN', yourScore),
        const Text(
          'VS',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        _buildScoreColumn('RAKİP', opponentScore),
      ],
    );
  }

  Widget _buildScoreColumn(String label, int score) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          score >= 0 ? '$score' : '-',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}