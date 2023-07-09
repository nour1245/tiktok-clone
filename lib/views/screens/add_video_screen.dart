import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/views/screens/confirm_screen.dart';
import 'package:tiktok_clone/views/widgets/constants.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            videoFile: File(video.path),
            vidoePath: video.path,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                pickVideo(ImageSource.gallery, context);
              },
              child: Container(
                width: media.width * 0.30,
                height: media.height * 0.18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image,
                      size: 70,
                    ),
                    SizedBox(
                      height: media.height * 0.01,
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(color: buttoncolor),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: media.width * 0.07,
            ),
            InkWell(
              onTap: () {
                pickVideo(ImageSource.camera, context);
              },
              child: SizedBox(
                width: media.width * 0.30,
                height: media.height * 0.18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera,
                      size: 70,
                    ),
                    SizedBox(
                      height: media.height * 0.01,
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(color: buttoncolor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
