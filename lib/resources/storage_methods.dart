import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // save image in firebase storage
  Future<String> uploadImage(
      String childName, Uint8List file, bool isPost) async {
    Reference reference = _firebaseStorage
        .ref()
        .child(childName)
        .child(_firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = reference.putData(file);

    TaskSnapshot snap = await uploadTask;
    String url = await snap.ref.getDownloadURL();

    return url;
  }
}
