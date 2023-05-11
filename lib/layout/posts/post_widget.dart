import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dermatology1/model/user.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../model/post_model.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final UserModel? userModel;
  const PostWidget({Key? key, required this.post, required this.userModel})
      : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _liked = false;
  TextEditingController _commentController = TextEditingController();
  List<Comment> _allComments = [];

  @override
  void initState() {
    super.initState();
    _liked = widget.post.likes.contains(widget.userModel!.id!);
    _retrieveAllComments();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.post.userProfileImageUrl),
                ),
                SizedBox(width: 8.0),
                Text(widget.post.userName),
              ],
            ),
            SizedBox(height: 8.0),
            Text(widget.post.content),
            SizedBox(height: 16.0),
            Divider(),
            Row(
              children: [
                IconButton(
                  icon: Icon(_liked ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      _liked = !_liked;
                      if (_liked) {
                        widget.post.likes.add(widget.userModel!.id!);
                      } else {
                        widget.post.likes.remove(widget.userModel!.id!);
                      }
                    });
                    _updateLikes();
                  },
                ),
                Text("${widget.post.likes.length} Likes"),
                SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return Color.fromRGBO(137, 121, 113, 5);
                        },
                      ),
                    ),
                    child: Text("Comments (${_allComments.length})"),
                    onPressed: () {
                      _showCommentsDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // void _showCommentsDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Comments"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: _allComments.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 final comment = _allComments[index];
  //                 return ListTile(
  //                   leading: CircleAvatar(
  //                     backgroundImage:
  //                         NetworkImage(comment.userProfileImageUrl),
  //                   ),
  //                   title: Text(comment.userName),
  //                   subtitle: Text(comment.content),
  //                 );
  //               },
  //             ),
  //             TextFormField(
  //               controller: _commentController,
  //               decoration: InputDecoration(
  //                 labelText: "Add a comment",
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             child: Text("Cancel"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           ElevatedButton(
  //             child: Text("Post"),
  //             onPressed: () {
  //               _addComment();
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _updateLikes() {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.post.id)
        .update({'likes': widget.post.likes});
  }

  void _addComment() {
    final comment = Comment(
      id: const Uuid().v1(),
      content: _commentController.text,
      userId: widget.userModel!.id!,
      userName: widget.userModel!.fname!,
      userProfileImageUrl: '',
    );
    setState(() {
      widget.post.comments.add(comment);
      _allComments.add(comment);
    });
    FirebaseFirestore.instance.collection('posts').doc(widget.post.id).update({
      'comments':
          widget.post.comments.map((comment) => comment.toMap()).toList()
    });
    _commentController.clear();
  }

  void _retrieveAllComments() async {
    List<Comment> allComments = [];
    for (Comment comment in widget.post.comments) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(comment.userId)
          .get();
      UserModel userModel = UserModel.fromSnapShot(snapshot);
      Comment commentWithUser = Comment(
        id: comment.id,
        content: comment.content,
        userId: userModel.id!,
        userName: userModel.fname!,
        userProfileImageUrl: '',
      );
      allComments.add(commentWithUser);
    }
    setState(() {
      _allComments = allComments;
    });
  }

  void _showCommentsDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Comments"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.post.comments.length,
                itemBuilder: (BuildContext context, int index) {
                  final comment = widget.post.comments[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(comment.userProfileImageUrl),
                    ),
                    title: Text(comment.userName),
                    subtitle: Text(comment.content),
                  );
                },
              ),
              TextFormField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: "Add a comment",
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Comment"),
              onPressed: () {
                _addComment();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
