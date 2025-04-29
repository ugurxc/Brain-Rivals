import 'package:brain_rivals/screens/mesage_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final userRepo = Provider.of<UserRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arkadaşlarım'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Arama sayfasına yönlendirme
            },
          ),
        ],
      ),
      body: StreamBuilder<List<MyUser>>(
        stream: userRepo.getFriendsStream(currentUserId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final friends = snapshot.data ?? [];

          if (friends.isEmpty) {
            return const Center(
              child: Text('Henüz arkadaş eklemediniz'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: friends.length,
            itemBuilder: (context, index) {
              final friend = friends[index];
              return _FriendListItem(friend: friend);
            },
          );
        },
      ),
    );
  }
}

class _FriendListItem extends StatelessWidget {
  final MyUser friend;

  const _FriendListItem({required this.friend});

  @override
  Widget build(BuildContext context) {
    final userRepo = Provider.of<UserRepository>(context, listen: false);
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Dismissible(
      key: Key(friend.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Arkadaşlığı Sil'),
            content: const Text('Bu kişiyi arkadaş listenizden çıkarmak istediğinize emin misiniz?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('İptal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Sil', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) async {
        try {
          await userRepo.removeFriend(currentUserId, friend.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${friend.name} arkadaş listenizden çıkarıldı')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hata: ${e.toString()}')),
          );
        }
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: friend.picture?.isNotEmpty == true
              ? AssetImage(friend.picture!)
              : const AssetImage('assets/default_avatar.png') as ImageProvider,
        ),
        title: Text(friend.name),
        subtitle: Text(friend.email),
        trailing: IconButton(
          icon: const Icon(Icons.message),
          onPressed: () {
            Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ChatScreen(
      friendName: friend.name,
      friendImageUrl: friend.picture,
    ),
  ),
);
          },
        ),
      ),
    );
  }
}