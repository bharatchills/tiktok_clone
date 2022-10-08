import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String songName;
  String caption;
  String videoUrl;

  Video({
    required this.songName,
    required this.caption,
    required this.videoUrl,
    // required this.thumbnail,
  });

  Map<String, dynamic> toJson() => {
        "songName": songName,
        "caption": caption,
        "videoUrl": videoUrl,
        // "thumbnail": thumbnail,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      songName: snapshot['songName'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      // thumbnail: snapshot['thumbnail'],
    );
  }
}
