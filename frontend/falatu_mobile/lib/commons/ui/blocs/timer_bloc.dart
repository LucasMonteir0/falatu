import "dart:async";
import "package:flutter_bloc/flutter_bloc.dart";

class TimerBloc extends Cubit<Duration> {
  TimerBloc() : super(Duration.zero);

  Timer? _timer;
  bool _isPaused = false;
  bool _isStopped = false;

  void start() {
    emit(Duration.zero);
    _isPaused = false;
    _isStopped = false;
    _timer ??= Timer.periodic(
      const Duration(seconds: 1),
      (_) => _isPaused || _isStopped
          ? null
          : emit(state + const Duration(seconds: 1)),
    );
  }

  void toggle() => _isPaused = !_isPaused;

  void stop() {
    _isPaused = false;
    _isStopped = true;
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
