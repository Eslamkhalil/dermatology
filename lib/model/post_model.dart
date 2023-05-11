import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String content;
  final String userId;
  final String userName;
  final String userProfileImageUrl;
  final Timestamp createdAt;
  List<String> likes;
  List<Comment> comments;

  Post({
    required this.id,
    required this.content,
    required this.userId,
    required this.userName,
    required this.userProfileImageUrl,
    required this.createdAt,
    this.likes = const [],
    this.comments = const [],
  });

  factory Post.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Post(
      id: document.id,
      content: data['content'],
      userId: data['userId'],
      userName: data['userName'],
      userProfileImageUrl: data['userProfileImageUrl'],
      createdAt: data['createdAt'],
      likes: List.from(data['likes'] ?? []),
      comments: List.from(data['comments'] ?? []).map((c) => Comment.fromMap(c)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'userId': userId,
      'userName': userName,
      'userProfileImageUrl': userProfileImageUrl,
      'createdAt': createdAt,
      'likes': likes,
      'comments': comments.map((c) => c.toMap()).toList(),
    };
  }
}

class Comment {
  final String id;
  final String content;
  final String userId;
  final String userName;
  final String userProfileImageUrl;

  Comment({
    required this.id,
    required this.content,
    required this.userId,
    required this.userName,
    required this.userProfileImageUrl,
  });

  factory Comment.fromMap(Map<String, dynamic> data) {
    return Comment(
      id: data['id'],
      content: data['content'],
      userId: data['userId'],
      userName: data['userName'],
      userProfileImageUrl: data['userProfileImageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'userId': userId,
      'userName': userName,
      'userProfileImageUrl': userProfileImageUrl,
    };
  }
}