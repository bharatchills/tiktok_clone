import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../constants.dart';
import '../models/video.dart';

class UploadController {
  var uuid = Uuid().v1();

  Future<String> _uploadVideoToStorage(String id, File videoFile) async {
    print("upload video");
    Reference ref = firebaseStorage.ref().child('videos');

    UploadTask uploadTask = ref.child(uuid).putFile(videoFile);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(
      String songName, String caption, File videoFile, BuildContext context,
      [bool mounted = true]) async {
    try {
      // String uid = firebaseAuth.currentUser!.uid;
      // DocumentSnapshot userDoc = await firestore
      //     .collection('users')
      //     .doc(uid)
      //     .get();
      // get id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      print("$len");
      String videoUrl = await _uploadVideoToStorage("Video $len", videoFile);
      // String thumbnail = await _uploadImageToStorage("Video $len", videoFile);

      Video video = Video(
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
      );

      await firestore.collection('videos').doc(uuid).set(
            video.toJson(),
          );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      var snackBar = SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
