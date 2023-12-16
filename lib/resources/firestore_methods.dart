import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttergram/models/post.dart';
import 'package:fluttergram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(Uint8List file, String description, String uid,
      String username, String profilePicUrl) async {
    String res = 'some error occured';

    String postId = const Uuid().v1();
    try {
      String photoUrl = await StorageMethods().uploadImage('posts', file, true);

      Post post = Post(
        postId: postId,
        description: description,
        postUrl: photoUrl,
        uid: uid,
        username: username,
        datePublished: DateTime.now(),
        profImage: profilePicUrl,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = 'success';
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
