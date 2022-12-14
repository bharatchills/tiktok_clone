import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktok_clone2/views/video_screen.dart';

import 'views/add_video.dart';

List pages = [
  VideoScreen(),
  Center(
    child: Text("Search"),
  ),
  AddVideoScreen(),
  Center(
    child: Text("Message"),
  ),
  Center(
    child: Text("Profile"),
  ),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;
