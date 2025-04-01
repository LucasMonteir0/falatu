import "dart:io";

import "package:chewie/chewie.dart";
import "package:cross_file/cross_file.dart";
import "package:flutter/material.dart";
import "package:video_player/video_player.dart";

enum _SourceType {
  network,
  file;
}

class FalaTuVideoPlayer extends StatefulWidget {
  final String? _url;
  final XFile? _file;
  final _SourceType _source;

  const FalaTuVideoPlayer.network({super.key, required String url})
      : _url = url,
        _source = _SourceType.network,
        _file = null;

  const FalaTuVideoPlayer.file({super.key, required XFile file})
      : _url = null,
        _source = _SourceType.file,
        _file = file;

  @override
  State<FalaTuVideoPlayer> createState() => _FalaTuVideoPlayerState();
}

class _FalaTuVideoPlayerState extends State<FalaTuVideoPlayer> {
  late final VideoPlayerController _controller;
  late final ChewieController _chewie;

  VideoPlayerController _handleType() {
    switch (widget._source) {
      case _SourceType.network:
        return VideoPlayerController.networkUrl(Uri.parse(widget._url!));
      case _SourceType.file:
        return VideoPlayerController.file(File(widget._file!.path));
    }
  }

  ChewieController _setChewie(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ChewieController(
      videoPlayerController: _controller,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: colors.primary,
        handleColor: colors.secondary,
        backgroundColor: colors.primary.withValues(alpha: 0.2),
        bufferedColor: colors.primary.withValues(alpha: 0.2),
      ),
      cupertinoProgressColors: ChewieProgressColors(
        playedColor: colors.primary,
        handleColor: colors.secondary,
        backgroundColor: colors.primary.withValues(alpha: 0.2),
        bufferedColor: colors.primary.withValues(alpha: 0.2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = _handleType();
    _controller.setLooping(true);
    _controller.setVolume(1);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chewie = _setChewie(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 150)),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            return SafeArea(child: Chewie(controller: _chewie));
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        });
  }

  @override
  void dispose() {
    _chewie.dispose();
    _controller.dispose();
    super.dispose();
  }
}
