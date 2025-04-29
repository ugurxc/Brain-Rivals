import 'package:brain_rivals/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:brain_rivals/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfile extends StatefulWidget {
  final String userId;

  const MyProfile({super.key, required this.userId});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final List<String> avatarPaths = [
    'assets/images/11.png',
    'assets/images/22.png',
    'assets/images/33.png',
    'assets/images/44.png',
    'assets/images/55.png',
    'assets/images/6.png',
    'assets/images/77.png',
    'assets/images/88.png',
  ];

 String? selectedAvatar;

  @override
  void initState() {
    super.initState();
    _loadSelectedAvatar();
  }

  Future<void> _loadSelectedAvatar() async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
    setState(() {
      selectedAvatar = userDoc.data()?['picture']; 
    });
  }

  Future<void> _saveSelectedAvatar(String avatarPath) async {
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'picture': avatarPath,
    });
    setState(() {
      selectedAvatar = avatarPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kPrimaryLightColor,

      child: SizedBox(
        height: 500,
        child: Column(
          children: [
            Column(
              children: [
                const Text('Seçilen Avatar:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , fontFamily: 'SF Pro',) ),
                 selectedAvatar == null
          ? const CircleAvatar(
            backgroundColor: Colors.white,
             radius: 50,
            child: CircularProgressIndicator( )) // Yükleniyor animasyonu
          :
                Container(
                  decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                         
                             color:  Colors.green,
                            
                          width: 4,
                        ),
                      ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(selectedAvatar!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Avatar Seçin:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: avatarPaths.length,
                itemBuilder: (context, index) {
                  final avatarPath = avatarPaths[index];
                  return GestureDetector(
                    onTap: () async {
                     await _saveSelectedAvatar(avatarPath); 
                      context.read<MyUserBloc>().add(
                  UpdateUserPicture(
            userId:widget.userId, // mevcut kullanıcının ID'si
            newPicture: avatarPath,
          ),
        );
          // Geri dön
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Avatar seçildi!')),
                      );
                    },
                    child: Container(
                          decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedAvatar == avatarPath
                              ? Colors.green
                              : Colors.transparent,
                          width: 4,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(avatarPath),
                       
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}