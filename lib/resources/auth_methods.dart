import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergram/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //signup user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? file,
  }) async {
    String res = 'Error occured';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String profilePicUrl =
            await StorageMethods().uploadImage('profilePics', file, false);

        //add user to firestore
        await _firebaseFirestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'profilePicUrl': profilePicUrl
        });
        res = 'success';
      } else {
        return res;
      }
    } catch (err) {
      // TODO: error messages
      res = err.toString();
    }
    return res;
  }

  // signin user
  Future<String> signinUser(
      {required String email, required String password}) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter email & password';
      }
    } catch (err) {
      // TODO: error messages
      res = err.toString();
    }
    return res;
  }
}
