import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/upload_video.dart';
import 'package:tiktok_clone/views/widgets/text_input.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen(
      {super.key, required this.videoFile, required this.vidoePath});
  final String vidoePath;
  final File videoFile;
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController videoPlayerController;
  TextEditingController SongController = TextEditingController();
  TextEditingController CaptionController = TextEditingController();
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setVolume(1);
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
    videoPlayerController.pause();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            FutureBuilder(
              future: videoPlayerController.initialize(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: media.width,
                    height: media.height / 1.5,
                    child: VideoPlayer(videoPlayerController),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: media.width - 20,
                    child: TextInputField(
                      isObscure: false,
                      controller: SongController,
                      hintText: 'Song Name',
                      icon: Icons.music_note_rounded,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: media.width - 20,
                    child: TextInputField(
                      isObscure: false,
                      controller: CaptionController,
                      hintText: 'Caption',
                      icon: Icons.closed_caption,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => uploadVideoController.uploadVideo(
                      SongController.text,
                      CaptionController.text,
                      widget.vidoePath,
                    ),
                    child: Text('Share'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
