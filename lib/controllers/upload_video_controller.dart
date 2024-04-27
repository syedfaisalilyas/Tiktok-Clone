import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video.dart';
import 'package:video_compress/video_compress.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    final url = Uri.parse(
        'https://tiktok-22380-default-rtdb.firebaseio.com/videos/$id.json');
    final videoBytes = File(videoPath).readAsBytesSync();
    final response = await http.post(
      url,
      body: videoBytes,
      headers: {
        'Content-Type': 'application/octet-stream',
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['downloadUrl'];
    } else {
      throw Exception('Failed to upload video');
    }
  }

  Future<String> _uploadImageToStorage(String id, String imagePath) async {
    final url = Uri.parse(
        'https://tiktok-22380-default-rtdb.firebaseio.com/thumbnails/$id.json');
    final imageBytes = File(imagePath).readAsBytesSync();
    final response = await http.post(
      url,
      body: imageBytes,
      headers: {
        'Content-Type': 'application/octet-stream',
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['downloadUrl'];
    } else {
      throw Exception('Failed to upload image');
    }
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  // upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = Firebase_auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await Firestore.collection('users').doc(uid).get();
      // get id
      var allDocs = await Firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
        thumbnail: thumbnail,
      );

      await Firestore.collection('videos').doc('Video $len').set(
            video.toJson(),
          );
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}
