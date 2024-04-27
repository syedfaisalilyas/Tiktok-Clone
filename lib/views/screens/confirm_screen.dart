import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';
import 'package:tiktok_clone/views/screens/video_screen.dart';
import 'package:tiktok_clone/views/screens/widgets/textinputfield.dart';
import 'package:video_player/video_player.dart';
// import 'package:permission_handler/permission_handler.dart';

class Confrim_Video extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const Confrim_Video({
    super.key,
    required this.videoFile,
    required this.videoPath,
  });

  @override
  State<Confrim_Video> createState() => _Confrim_VideoState();
}

class _Confrim_VideoState extends State<Confrim_Video> {
  late VideoPlayerController controller;
  late ChewieController _chewieController;
  TextEditingController _Captionditingcontroller = TextEditingController();
  TextEditingController _Songeditingcontroller = TextEditingController();

  UploadVideoController _uploadVideoController =
      Get.put(UploadVideoController());
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/main2.mp4');
    // controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    // );
    // controller = VideoPlayerController.file(widget.videoFile);
    _chewieController = ChewieController(videoPlayerController: controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
    controller.initialize();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _requestPermissions(); // Request permissions before accessing the video
  //   setState(() {
  //     controller = VideoPlayerController.file(widget.videoFile);
  //   });
  //   controller
  //       .initialize()
  //       .then((_) => setState(() {})); // Update UI after initialization
  //   controller.play();
  //   controller.setVolume(1);
  //   controller.setLooping(true);
  // }

  // Future<void> _requestPermissions() async {
  //   // Request storage and microphone permissions (if needed)
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //     Permission.microphone,
  //   ].request();
  //   if (statuses[Permission.storage] != PermissionStatus.granted ||
  //       statuses[Permission.microphone] != PermissionStatus.granted) {
  //     // Handle permission denial if needed
  //     print("Permissions not granted");
  //   }
  // }

  @override
  void dispose() {
    controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Chewie(controller: _chewieController),
              // VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _Songeditingcontroller,
                      label: 'Sound Name',
                      prefixicon: Icons.music_note,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _Captionditingcontroller,
                      label: 'Caption',
                      prefixicon: Icons.closed_caption,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _uploadVideoController.uploadVideo(
                        _Songeditingcontroller.text,
                        _Captionditingcontroller.text,
                        widget.videoPath,
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const HomeScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Share',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
