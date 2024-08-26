import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoItems extends StatefulWidget {
  late final VideoPlayerController videoPlayerController;
  //late final ChewieController _chewieController;
  late final bool looping;
  late final bool autoplay;
  final VoidCallback? onTap;

  VideoItems({
    required this.videoPlayerController,
    required this.looping,
    required this.autoplay,
    this.onTap,
    Key? key,
  }) : super(key: key);
  @override
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  late ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 5 / 8,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.autoplay,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Stack(children: [
            Chewie(
              controller: _chewieController,
            ),
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: widget.onTap,
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    )))
          ]),
        ));
  }
}
