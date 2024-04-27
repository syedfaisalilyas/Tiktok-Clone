import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/add_a_Video.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:tiktok_clone/views/screens/search_screen.dart';
import 'package:tiktok_clone/views/screens/video_screen.dart';

var pages = [
  VideoScreen(),
  SearchScreen(),
  AddVideo(),
  Center(child: Text('Message screen')),
  ProfileScreen(uid: authcontroller.user.uid),
];
// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// FIREBASE
var Firebase_auth = FirebaseAuth.instance;
var Firebase_storage = FirebaseStorage.instance;
var Firestore = FirebaseFirestore.instance;

// CONTROLLERS
var authcontroller = Auth_Controller.instance;
