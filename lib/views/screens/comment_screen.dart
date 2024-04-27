import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatefulWidget {
  final String id;

  CommentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    // Fetch comments for the given video ID
    // You can replace this with your own logic to fetch comments from a database
    fetchComments(widget.id);
  }

  void fetchComments(String videoId) {
    // Simulated comments
    setState(() {
      comments = [
        Comment(
          username: 'User1',
          profilePhoto: 'profile1.jpg',
          comment: 'Great video!',
          datePublished: DateTime.now().subtract(Duration(hours: 2)),
          likes: ['user1', 'user2'],
        ),
        Comment(
          username: 'User2',
          profilePhoto: 'profile2.jpg',
          comment: 'Nice one!',
          datePublished: DateTime.now().subtract(Duration(hours: 1)),
          likes: ['user3'],
        ),
      ];
    });
  }

  void postComment(String comment) {
    // Simulated comment posting
    // You can replace this with your own logic to post comments to a database
    setState(() {
      comments.add(
        Comment(
          username: 'You',
          profilePhoto: 'your_profile.jpg',
          comment: comment,
          datePublished: DateTime.now(),
          likes: [],
        ),
      );
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: AssetImage(comment.profilePhoto),
                      ),
                      title: Row(
                        children: [
                          Text(
                            "${comment.username}  ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            comment.comment,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            tago.format(
                              comment.datePublished,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${comment.likes.length} likes',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      trailing: InkWell(
                        onTap: () {
                          // Logic to like/unlike comment
                          setState(() {
                            if (comment.likes
                                .contains(authcontroller.user.uid)) {
                              comment.likes.remove(authcontroller.user.uid);
                            } else {
                              comment.likes.add(authcontroller.user.uid);
                            }
                          });
                        },
                        child: Icon(
                          Icons.favorite,
                          size: 25,
                          color: comment.likes.contains(authcontroller.user.uid)
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () => postComment(_commentController.text),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Comment {
  final String username;
  final String profilePhoto;
  final String comment;
  final DateTime datePublished;
  final List<String> likes;

  Comment({
    required this.username,
    required this.profilePhoto,
    required this.comment,
    required this.datePublished,
    required this.likes,
  });
}
