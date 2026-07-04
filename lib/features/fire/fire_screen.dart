import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/time_utils.dart';
import '../../data/database.dart';
import '../../data/providers.dart';
import '../../services/audio_service.dart';
import '../../theme/app_theme.dart';

/// Full-screen alarm shown when a routine fires (or "Disparar agora").
class FireScreen extends ConsumerStatefulWidget {
  const FireScreen({super.key, required this.routine, required this.type});
  final Routine routine;
  final RoutineType? type;

  @override
  ConsumerState<FireScreen> createState() => _FireScreenState();
}

class _FireScreenState extends ConsumerState<FireScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    AudioService.instance.play(
      sourceId: widget.routine.soundSourceId,
      ref: widget.routine.soundRef,
      volume: widget.routine.volume,
      fadeIn: widget.routine.fadeIn,
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _done() async {
    await AudioService.instance.stop();
    await ref.read(repositoryProvider).markDone(widget.routine);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _snooze() async {
    await AudioService.instance.stop();
    await ref.read(repositoryProvider).snooze(widget.routine, 5);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.type?.icon ?? '⏰';
    final label = widget.routine.soundLabel ??
        (widget.routine.soundSourceId == 1 ? 'alarme padrão' : 'música');
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.25),
            radius: 0.9,
            colors: [Color(0x2238BDF8), Colors.transparent],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                const Spacer(),
                ScaleTransition(
                  scale: Tween(begin: 1.0, end: 1.08).animate(
                    CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
                  ),
                  child: Text(icon, style: const TextStyle(fontSize: 64)),
                ),
                const SizedBox(height: 10),
                Text(widget.routine.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(TimeUtils.clock(DateTime.now().millisecondsSinceEpoch),
                    style: const TextStyle(
                        fontFamily: kMonoFont, fontSize: 16, color: AppColors.muted)),
                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.music_note, size: 14, color: AppColors.cyan),
                  const SizedBox(width: 6),
                  Text('tocando: $label',
                      style: const TextStyle(color: AppColors.cyan, fontSize: 12)),
                ]),
                const Spacer(),
                Row(children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _snooze,
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                      child: const Text('Soneca 5min'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _done,
                      style: FilledButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          foregroundColor: const Color(0xFF3A2F06),
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                      child: const Text('Feito'),
                    ),
                  ),
                ]),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      await AudioService.instance.stop();
                      if (context.mounted) Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.bad,
                      side: const BorderSide(color: AppColors.bad),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Parar som'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
