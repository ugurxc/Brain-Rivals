import 'package:brain_rivals/constant.dart';

import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class OtherProfilePage extends StatelessWidget {
  final MyUser user;
  const OtherProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryLightColor,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
        title: Text(
          user.name,
          style: const TextStyle(color: Colors.black87, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: user.picture != null
                  ? AssetImage(user.picture!)
                  : null,
              backgroundColor: Colors.grey[200],
              child: user.picture == null
                  ? const Icon(Icons.person, size: 60, color: Colors.grey)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user.email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('Galibiyet', user.win),
                _buildStatCard('Mağlubiyet', user.lose),
              ],
            ),
            const SizedBox(height: 24),
             Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.emoji_events, size: 48, color: Colors.amber),
                    const SizedBox(height: 8),
                    Text(
                      'Brain Rivals Arenasında ${user.name}🌟',
                      style: const TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, int value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 140,
        child: Column(
          children: [
            Text(
              '$value',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
