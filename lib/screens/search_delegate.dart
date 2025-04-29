/* import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
class UserSearchDelegate extends SearchDelegate<MyUser> {
  final List<MyUser> allUsers;
  final UserRepository _userRepository;
  UserSearchDelegate(this.allUsers ,this._userRepository);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Arama sorgusunu temizler
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
   
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, MyUser.empty); // Arama ekranını kapatır
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Kullanıcıların listesi Firestore'dan gelecek
    return FutureBuilder<List<MyUser>>(
      future: _userRepository.searchUsers(query), // Firestore'da kullanıcıları arama fonksiyonu
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Sonuç bulunamadı'));
        }
        final results = snapshot.data!;
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: TextButton(onPressed: () {
                
              }, child: const Text("Ekle")),
              title: Text(results[index].name),
              subtitle: Text(results[index].email),
              leading:  CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: 
              results[index].picture !=""
              ? AssetImage(results[index].picture!)
              : const NetworkImage('https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y')
                                
                                  
                                
                              ), 
              onTap: () {
               /*  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                 return UserProfilePage(thisUser: results[index]);
                },)); */ // Seçilen kullanıcıyı kapatır
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Kullanıcı sorgusuna göre öneriler (sadece sonuçları göster)
    return query.isEmpty
        ? const Center(child: Text('Kullanıcı adını girin'))
        : buildResults(context);
  }
} */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class UserSearchDelegate extends SearchDelegate<MyUser> {
  final List<MyUser> allUsers;
  final UserRepository _userRepository;
  final String _currentUserId;

  UserSearchDelegate(this.allUsers, this._userRepository)
      : _currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, MyUser.empty),
    );
  }

  Widget _buildFriendButton(MyUser targetUser) {
    // Kendi profilini gizle
    if (targetUser.id == _currentUserId) return const SizedBox.shrink();

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _userRepository.friendRequestsStream(_currentUserId),
      builder: (context, snapshot) {
        final requests = snapshot.data ?? [];
        final existingRequest = requests.firstWhere(
          (req) => req['to'] == targetUser.id && req['from'] == _currentUserId,
          orElse: () => {},
        );

        final isFriend = targetUser.friends.contains(_currentUserId);

        if (isFriend) {
          return const TextButton(
            onPressed: null,
            child: Text('Arkadaş', style: TextStyle(color: Colors.grey)),
          );
        }

        if (existingRequest.isNotEmpty) {
          return TextButton(
            onPressed: null,
            child: Text(
              existingRequest['status'] == 'pending' ? 'İstek Gönderildi' : 'Hata',
              style: const TextStyle(color: Colors.grey),
            ),
          );
        }

        return TextButton(
          onPressed: () => _sendFriendRequest(context, targetUser),
          child: const Text("Ekle", style: TextStyle(color: Colors.blue)),
        );
      },
    );
  }

  Future<void> _sendFriendRequest(BuildContext context, MyUser targetUser) async {
    try {
      await _userRepository.sendFriendRequest(_currentUserId, targetUser.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${targetUser.name} kullanıcısına istek gönderildi')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: ${e.toString()}')),
      );
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<MyUser>>(
      future: _userRepository.searchUsers(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Sonuç bulunamadı'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final user = snapshot.data![index];
            return ListTile(
              trailing: _buildFriendButton(user),
              title: Text(user.name),
              subtitle: Text(user.email),
              leading: CircleAvatar(
                backgroundImage: user.picture?.isNotEmpty == true
                    ? AssetImage(user.picture!)
                    : const NetworkImage('https://via.placeholder.com/150'),
              ),
              onTap: () {
                // Kullanıcı profil sayfasına git
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? const Center(child: Text('Arama yapmak için yazmaya başlayın'))
        : buildResults(context);
  }
}