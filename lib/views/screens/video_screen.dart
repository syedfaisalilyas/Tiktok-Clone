import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/widgets/video_player_item.dart';
import 'package:tiktok_clone/views/screens/comment_screen.dart'; // Import the CommentScreen widget
import 'dart:math';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final Random _random = Random();
  late List<bool> _likedStates;
  late List<int> _likeCounts;
  late List<int> _commentCounts;
  late List<int> _shareCounts;
  late List<String> _captions;
  final videoUrls = [
    'assets/main1.mp4',
    'assets/main2.mp4',
    'assets/main3.mp4',
    'assets/main4.mp4',
    'assets/main5.mp4',
    'assets/shair.mp4',
    'assets/shair2.mp4',
  ];
  @override
  void initState() {
    super.initState();
    _likedStates = List.generate(videoUrls.length, (index) => false);
    _likeCounts =
        List.generate(videoUrls.length, (index) => _random.nextInt(100));
    _commentCounts =
        List.generate(videoUrls.length, (index) => _random.nextInt(100));
    _shareCounts =
        List.generate(videoUrls.length, (index) => _random.nextInt(100));
    _captions =
        List.generate(videoUrls.length, (index) => _generateRandomCaption());
  }

  String _generateRandomUsername() {
    return 'User${_random.nextInt(100)}';
  }

  String _generateRandomCaption() {
    return 'Caption${_random.nextInt(100)}';
  }

  String _generateRandomSongName() {
    return 'Sound${_random.nextInt(100)}';
  }

  Widget buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  profilePhoto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                profilePhoto,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView.builder(
        itemCount: videoUrls.length,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final username = _generateRandomUsername();
          final songName = _generateRandomSongName();
          var profilePhoto = 'assets/Faisal_Shah.png';

          return Center(
            child: Stack(
              children: [
                VideoPlayerItem(
                  videoUrl: videoUrls[index],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    username,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _captions[index],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.music_note,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        songName,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(top: size.height / 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildProfile(profilePhoto),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _likedStates[index] =
                                              !_likedStates[index];
                                          if (_likedStates[index]) {
                                            _likeCounts[index]++;
                                          } else {
                                            _likeCounts[index]--;
                                          }
                                        });
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        size: 40,
                                        color: _likedStates[index]
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      _likeCounts[index].toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    // Navigate to the CommentScreen when the comment icon is tapped
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommentScreen(
                                          id: videoUrls[
                                              index], // Pass video ID to CommentScreen
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.comment,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        _commentCounts[index].toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _shareCounts[index]++;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.share,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        _shareCounts[index].toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                buildMusicAlbum(profilePhoto),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
