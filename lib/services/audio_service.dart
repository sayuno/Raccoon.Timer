import 'package:just_audio/just_audio.dart';

/// Plays the sound bound to a routine when it fires.
///
/// v1 supports `default_alarm` (bundled asset) and `local` (a file path picked
/// from the phone). `spotify` (sourceId 3) is stubbed — playback via the
/// Spotify App Remote SDK lands in a later slice once the account-connect flow
/// in Settings is wired.
class AudioService {
  AudioService._();
  static final AudioService instance = AudioService._();

  final _player = AudioPlayer();

  static const _defaultAsset = 'assets/sounds/alarm1.mp3';

  /// [sourceId]: 1 = default_alarm, 2 = local, 3 = spotify.
  Future<void> play({
    required int sourceId,
    String? ref,
    int volume = 80,
    bool fadeIn = false,
  }) async {
    try {
      switch (sourceId) {
        case 2: // local file
          if (ref == null) return;
          await _player.setFilePath(ref);
          break;
        case 3: // spotify — not yet wired; fall back to the default tone
          await _player.setAsset(_defaultAsset);
          break;
        case 1:
        default:
          await _player.setAsset(_defaultAsset);
      }
      await _player.setLoopMode(LoopMode.one);
      await _player.setVolume(fadeIn ? 0 : volume / 100);
      await _player.play();
      if (fadeIn) await _fadeTo(volume / 100);
    } catch (_) {
      // A bad file path / missing asset must not crash the alarm.
    }
  }

  Future<void> _fadeTo(double target, {Duration over = const Duration(seconds: 4)}) async {
    const steps = 20;
    final stepMs = over.inMilliseconds ~/ steps;
    for (var i = 1; i <= steps; i++) {
      await Future.delayed(Duration(milliseconds: stepMs));
      await _player.setVolume(target * i / steps);
    }
  }

  Future<void> stop() => _player.stop();
}
