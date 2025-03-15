// import 'dart:io';
//
// import 'package:cached_chewie/cached_chewie.dart';
// import 'package:cached_video_player/cached_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:resigo_design_system/resigo_design_system.dart';
//
// enum _SourceType {
//   network,
//   file;
// }
//
// class VideoPlayer extends StatefulWidget {
//   final String? _url;
//   final File? _file;
//   final _SourceType _source;
//
//   const VideoPlayer.network({super.key, required String url})
//       : _url = url,
//         _source = _SourceType.network,
//         _file = null;
//
//   const VideoPlayer.file({super.key, required File file})
//       : _url = null,
//         _source = _SourceType.file,
//         _file = file;
//
//   @override
//   State<VideoPlayer> createState() => _VideoPlayerState();
// }
//
// class _VideoPlayerState extends State<VideoPlayer> {
//   final ValueNotifier<bool> updatePlayer = ValueNotifier<bool>(false);
//   late final CachedVideoPlayerController _controller;
//   late final ChewieController _chewieController;
//
//   CachedVideoPlayerController _handleController() {
//     switch (widget._source) {
//       case _SourceType.network:
//         return CachedVideoPlayerController.network(widget._url!);
//       case _SourceType.file:
//         return CachedVideoPlayerController.file(widget._file!);
//     }
//   }
//
//   @override
//   void initState() {
//     _controller = _handleController();
//     _controller.setLooping(true);
//     _controller.setVolume(1);
//     _chewieController = ChewieController(
//       videoPlayerController: _controller,
//       autoInitialize: true,
//       autoPlay: true,
//       looping: true,
//       materialProgressColors: ChewieProgressColors(
//         playedColor: ResiGoColors.secondaryBC_900,
//         handleColor: ResiGoColors.secondaryBC_900,
//         backgroundColor: ResiGoColors.surface_300,
//         bufferedColor: ResiGoColors.surface_300,
//       ),
//       cupertinoProgressColors: ChewieProgressColors(
//         playedColor: ResiGoColors.secondaryBC_900,
//         handleColor: ResiGoColors.secondaryBC_900,
//         backgroundColor: ResiGoColors.secondaryBC_900,
//         bufferedColor: ResiGoColors.surface_300,
//       ),
//       deviceOrientationsOnEnterFullScreen: [
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight
//       ],
//       deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: Future.delayed(const Duration(milliseconds: 150)),
//         builder: (context, snap) {
//           if (snap.connectionState == ConnectionState.done) {
//             return SafeArea(child: Chewie(controller: _chewieController));
//           }
//           return const Center(
//             child: CircularProgressIndicator(color: ResiGoColors.surfaceBC_50),
//           );
//         });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
