import "package:audio_waveforms/audio_waveforms.dart";
import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/utils/enums/audio_player_state.dart";

abstract class AudioPlayerService {
  Future<Duration> init(XFile file, {int? samplesQuantity});

  Future<void> play();

  Future<void> stop();

  Future<void> pause();

  void dispose();

  Future<Duration> getDuration();

  PlayerController getController();

  Stream<Duration> progressStream();

  Stream<AudioPlayerState> stateStream();
}
