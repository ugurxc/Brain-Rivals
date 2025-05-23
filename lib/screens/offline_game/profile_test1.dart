import 'package:brain_rivals/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:brain_rivals/constant.dart';
import 'package:brain_rivals/screens/my_profile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, state) {
        if (state.status != MyUserStatus.succsess || state.user == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = state.user!;

        return Scaffold(
          backgroundColor: kPrimaryLightColor,
          appBar: AppBar(
           
            centerTitle: true,
            title: const Text('Profilim'),
            backgroundColor: kPrimaryLightColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.picture != null
                      ? AssetImage(user.picture!)
                      : null,
                  backgroundColor: Colors.grey[200],
                  child: user.picture == null
                      ? const Icon(Icons.person, size: 60)
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
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard('Kazandığı Oyun', state.user?.win ?? 10),
                    _buildStatCard('Kaybettiği Oyun', state.user?.lose ?? 10),
                  ],
                ),
                Image.asset("assets/images/gaga.png" , height: 200,),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => MyProfile(userId: user.id),
                    );
                  
                  },
                  style: ElevatedButton.styleFrom(
                    
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Profil Fotoğrafını Değiştir',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String label, int value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 150,
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
