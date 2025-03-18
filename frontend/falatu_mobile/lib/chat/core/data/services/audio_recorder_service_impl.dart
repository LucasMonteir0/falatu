import "package:audio_waveforms/audio_waveforms.dart";
import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/domain/services/audio_recorder_service.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";

class AudioRecorderServiceImpl implements AudioRecorderService {
  final RecorderController _recorder = RecorderController();

  @override
  RecorderController get controller => _recorder
    ..androidEncoder = AndroidEncoder.aac
    ..androidOutputFormat = AndroidOutputFormat.mpeg4
    ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
    ..sampleRate = 44100;

  @override
  bool get hasPermission => _recorder.hasPermission;

  @override
  Future<bool> checkPermission() async {
    if (!_recorder.hasPermission) {
      return await _recorder.checkPermission();
    }
    return true;
  }

  @override
  Future<void> start(String path) async {
    _recorder.updateFrequency = const Duration(milliseconds: 300);
    if(await checkPermission()) {
      await _recorder.record(path: path);
    }
  }

  @override
  Future<XFile?> stop() async {
    final path = await _recorder.stop();
    return path.let((p) => XFile(p));
  }

  @override
  void dispose() {
    _recorder.dispose();
  }

  @override
  Future<void> pause() async {
    await _recorder.pause();
  }
}
