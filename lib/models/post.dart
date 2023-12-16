// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String description;
  final String postUrl;
  final String uid;
  final String username;
  final DateTime datePublished;
  final String profImage;
  final likes;

  Post({
    required this.postId,
    required this.description,
    required this.postUrl,
    required this.uid,
    required this.username,
    required this.datePublished,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "description": description,
        'postUrl': postUrl,
        "uid": uid,
        "username": username,
        "datePublished": datePublished,
        'profImage': profImage,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      postId: snapshot["postId"],
      description: snapshot["description"],
      postUrl: snapshot['postUrl'],
      uid: snapshot["uid"],
      username: snapshot["username"],
      datePublished: snapshot["datePublished"],
      profImage: snapshot['profImage'],
      likes: snapshot["likes"],
    );
  }
}
