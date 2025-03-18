import "package:audio_waveforms/audio_waveforms.dart";
import "package:cross_file/cross_file.dart";

abstract class AudioRecorderService {
  Future<void> checkPermission();

  Future<void> start(String path);

  Future<XFile?> stop();

  Future<void> pause();

  void dispose();

  RecorderController get controller;

  bool get hasPermission;
}
