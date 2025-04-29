import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
class AuthService {

  Future<void> signIn({
    required String email,
    required String password

  }) async{
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log(e.toString());
    }
  }


  Future<void> signUp({
    required String email,
    required String name,
    required String password
  }) async{

    try {
   
       UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
     User? user = userCredential.user;

    if (user != null) {
      // Kullanıcı profilini güncelle (displayName olarak nickname'i ekle)
      await user.updateProfile(displayName: name);}

      
    } 
    catch (e) {
      log(e.toString());
    }
  }
}