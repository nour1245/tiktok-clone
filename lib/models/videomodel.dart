import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String userName;
  String uid;
  String id;
  List likes;
  int commentsCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePic;

  Video({
    required this.userName,
    required this.videoUrl,
    required this.uid,
    required this.thumbnail,
    required this.songName,
    required this.shareCount,
    required this.profilePic,
    required this.likes,
    required this.id,
    required this.commentsCount,
    required this.caption,
  });

  Map<String, dynamic> toJson() => {
        "name": userName,
        "uid": uid,
        "thumbnail": thumbnail,
        "songname": songName,
        "sharecount": shareCount,
        "profilepic": profilePic,
        "likes": likes,
        "id": id,
        "commnetscount": commentsCount,
        "caption": caption,
        "videourl": videoUrl,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      caption: snapshot['caption'],
      commentsCount: snapshot['commentscount'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      profilePic: snapshot['profilepic'],
      shareCount: snapshot['sharecount'],
      songName: snapshot['songname'],
      thumbnail: snapshot['thumbnail'],
      uid: snapshot['uid'],
      userName: snapshot['name'],
      videoUrl: snapshot['videourl'],
    );
  }
}
