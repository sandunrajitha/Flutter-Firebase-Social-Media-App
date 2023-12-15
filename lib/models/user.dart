class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final List followers;
  final List following;
  final String profilePicUrl;

  User({
    required this.username,
    required this.uid,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
    required this.profilePicUrl,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
        "profilePicUrl": profilePicUrl,
      };
}
