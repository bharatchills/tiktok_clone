import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'widgets/video_player_iten.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool isPlaying = true;
  var collectionStream = FirebaseFirestore.instance.collection('videos');

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://joy.videvo.net/videvo_files/video/free/2013-08/large_watermarked/hd0992_preview.mp4')
      ..initialize().then((_) {
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: collectionStream.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return PageView(
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Stack(
              children: [
                VideoPlayerItem(
                  videoUrl: data['videoUrl'],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.80,
                            color: Colors.amber,
                            child: Text(
                              "Song Name: ${data['songName']}",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.80,
                            color: Color.fromARGB(255, 255, 7, 214),
                            child: Text(
                              "Caption : ${data['caption']}",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ],
                )
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
