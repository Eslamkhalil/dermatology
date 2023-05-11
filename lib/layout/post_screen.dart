import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dermatology1/layout/posts/NewPostForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/post_model.dart';
import '../model/user.dart';
import '../services/auth.dart';
import 'posts/post_widget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');
  List<Post> posts = [];

  UserModel? userModel;

  void getUser() async {
    final _auth = AuthServices();
    var user = FirebaseAuth.instance.currentUser;
    var model =
        await _auth.getUser(user!.uid); // Execute asynchronous work first
    setState(() {
      userModel = model; // Update the state synchronously inside setState()
    });
  }

  Future<void> _getPosts() async {
    QuerySnapshot querySnapshot = await _postsCollection.get();
    List<Post> newPosts = [];
    for (var doc in querySnapshot.docs) {
      try {
        newPosts.add(Post.fromFirestore(doc));
      } catch (e) {
        print('Error loading post: $e');
      }
    }
    setState(() {
      posts = newPosts;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Posts',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/log.png"), fit: BoxFit.fill)),
        child: posts.isEmpty
            ? const Center(
                child: Text('No Posts'),
              )
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostWidget(
                    post: post,
                    userModel: userModel,
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewPostForm(
                      userModel: userModel!,
                    )),
          );
        },
        backgroundColor: Color.fromRGBO(137, 121, 113, 5),
        child: Icon(Icons.add),
      ),
    );
  }
}

// class PostWidget extends StatefulWidget {
//   final Post post;
//   final UserModel? userModel;
//   const PostWidget({super.key, required this.post, required this.userModel});

//   @override
//   _PostWidgetState createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> {
//   bool _liked = false;
//   TextEditingController _commentController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(widget.post.userProfileImageUrl),
//             ),
//             SizedBox(width: 8.0),
//             Text(widget.post.userName),
//           ],
//         ),
//         Text(widget.post.content),
//         Row(
//           children: [
//             IconButton(
//               icon: Icon(_liked ? Icons.favorite : Icons.favorite_border),
//               onPressed: () {
//                 setState(() {
//                   _liked = !_liked;
//                   if (_liked) {
//                     widget.post.likes.add(widget.userModel!.id!);
//                   } else {
//                     widget.post.likes.remove(widget.userModel!.id!);
//                   }
//                 });
//                 _updateLikes();
//               },
//             ),
//             ElevatedButton(
//               child: Text("Comments (${widget.post.comments.length})"),
//               onPressed: () {
//                 _showCommentsDialog();
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   void _showCommentsDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Comments"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: widget.post.comments.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final comment = widget.post.comments[index];
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage:
//                           NetworkImage(comment.userProfileImageUrl),
//                     ),
//                     title: Text(comment.userName),
//                     subtitle: Text(comment.content),
//                   );
//                 },
//               ),
//               TextFormField(
//                 controller: _commentController,
//                 decoration: InputDecoration(
//                   labelText: "Add a comment",
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               child: Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               child: Text("Post"),
//               onPressed: () {
//                 _addComment();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _updateLikes() {
//     FirebaseFirestore.instance
//         .collection('posts')
//         .doc(widget.post.id)
//         .update({'likes': widget.post.likes});
//   }

//   void _addComment() {
//     final comment = Comment(
//       id: const Uuid().v1(),
//       content: _commentController.text,
//       userId: widget.userModel!.id!,
//       userName: widget.userModel!.fname!,
//       userProfileImageUrl: '',
//     );
//     setState(() {
//       widget.post.comments.add(comment);
//     });
//     FirebaseFirestore.instance.collection('posts').doc(widget.post.id).update(
//         {'comments': widget.post.comments.map((c) => c.toMap()).toList()});
//     _commentController.clear();
//   }
// }
