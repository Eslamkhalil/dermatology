import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dermatology1/model/user.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../model/post_model.dart';

class NewPostForm extends StatefulWidget {
  const NewPostForm({Key? key , required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _postController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
              ),
            ),
          ),
          ElevatedButton(
            child: Text("Post"),
            onPressed: () {
              _addPost();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _addPost() {
    final post = Post(
      id: Uuid().v1(),
      content: _postController.text,
      userId: widget.userModel.id!,
      userName:  widget.userModel.fname!,
      userProfileImageUrl:  '',
      createdAt: Timestamp.now(),
      likes: [],
      comments: [],
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(post.id)
        .set(post.toMap());
    _postController.clear();
  }
}
