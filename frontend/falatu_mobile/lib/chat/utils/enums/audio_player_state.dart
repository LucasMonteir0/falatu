enum AudioPlayerState {
  idle,
  initialized,
  playing,
  paused,
  stopped;

  bool get isIdle => this == AudioPlayerState.idle;

  bool get isInitialized => this == AudioPlayerState.initialized;

  bool get isPlaying => this == AudioPlayerState.playing;

  bool get isPaused => this == AudioPlayerState.paused;

  bool get isStopped => this == AudioPlayerState.stopped;

  static AudioPlayerState fromValue(String value) {
    return AudioPlayerState.values.firstWhere((e) => e.name == value,
        orElse: () => AudioPlayerState.idle);
  }
}
