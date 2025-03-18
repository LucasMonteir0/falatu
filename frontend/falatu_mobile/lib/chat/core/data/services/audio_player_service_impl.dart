import "package:audio_waveforms/audio_waveforms.dart";
import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/domain/services/audio_player_service.dart";
import "package:falatu_mobile/chat/utils/enums/audio_player_state.dart";

class AudioPlayerServiceImpl implements AudioPlayerService {
  final PlayerController controller;

  AudioPlayerServiceImpl(this.controller);

  @override
  PlayerController getController() => controller;

  @override
  void dispose() {
    controller.dispose();
  }

  @override
  Future<Duration> init(XFile file, {int? samplesQuantity}) async {
    await controller
        .preparePlayer(path: file.path, noOfSamples: samplesQuantity ?? 100);

    return Duration(milliseconds: controller.maxDuration);
  }

  @override
  Future<void> pause() {
    return controller.pausePlayer();
  }

  @override
  Future<void> play() {
    return controller.startPlayer(forceRefresh: false);
  }

  @override
  Future<void> stop() {
    return controller.stopPlayer();
  }

  @override
  Future<Duration> getDuration() async {
    return Duration(milliseconds: await controller.getDuration());
  }

  @override
  Stream<Duration> progressStream() {
    return controller
        .onCurrentDurationChanged
        .map((e) => Duration(milliseconds: e));
  }

  @override
  Stream<AudioPlayerState> stateStream() {
    return controller
        .onPlayerStateChanged
        .map((e) => AudioPlayerState.fromValue(e.name));
  }
}
