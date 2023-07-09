import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/models/usermodel.dart';
import 'package:tiktok_clone/models/videomodel.dart';
import 'package:tiktok_clone/views/widgets/constants.dart';
import 'package:video_compress_plus/video_compress_plus.dart';

class UploadVideoController extends GetxController {
  //compress video
  comperssVideo(String videoPath) async {
    final comperssedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.HighestQuality,
    );

    return comperssedVideo!.file;
  }

  //upload to storge
  Future<String> uploadToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorge.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(
      await comperssVideo(videoPath),
    );
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //get thumbnails
  getThumbnail(String vidoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(vidoPath);
    return thumbnail;
  }

  //thumpnil
  Future<String> uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorge.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(
      await getThumbnail(videoPath),
    );
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //upload video function
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      //get id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await uploadToStorage("Video $len", videoPath);
      String thumbnail = await uploadImageToStorage("Video $len", videoPath);
      Video video = Video(
        userName: (userDoc.data()! as Map<String, dynamic>)['name'],
        videoUrl: videoUrl,
        uid: uid,
        thumbnail: thumbnail,
        songName: songName,
        shareCount: 0,
        profilePic: (userDoc.data()! as Map<String, dynamic>)['profilepic'],
        likes: [],
        id: "Video $len",
        commentsCount: 0,
        caption: caption,
      );
      await firestore.collection('videos').doc('Video $len').set(
            video.toJson(),
          );
      Get.back();
    } catch (e) {
      Get.snackbar("Error Uploading Video", e.toString());
    }
  }
}
