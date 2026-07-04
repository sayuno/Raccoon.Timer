import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/time_utils.dart';
import '../../data/database.dart';
import '../../data/providers.dart';
import '../../theme/app_theme.dart';
import '../fire/fire_screen.dart';
import '../routine_editor/routine_editor_screen.dart';

class RoutineDetailScreen extends ConsumerWidget {
  const RoutineDetailScreen({super.key, required this.routineId});
  final int routineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routines = ref.watch(routinesProvider).value ?? const [];
    final types = ref.watch(typesProvider).value ?? const {};
    final nowMs = ref.watch(tickerProvider).value ?? DateTime.now().millisecondsSinceEpoch;
    final logs = ref.watch(logsProvider(routineId)).value ?? const [];

    Routine? r;
    for (final x in routines) {
      if (x.id == routineId) r = x;
    }
    if (r == null) {
      return const Scaffold(body: Center(child: Text('Rotina não encontrada')));
    }
    final routine = r;
    final type = types[routine.typeId];
    final target = routine.snoozeUntil ?? routine.nextTriggerAt;

    return Scaffold(
      appBar: AppBar(
        title: Text('${type?.icon ?? '⏰'} ${routine.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => RoutineEditorScreen(existing: routine))),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmArchive(context, ref, routine),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          const Center(
            child: Text('PRÓXIMO DISPARO',
                style: TextStyle(fontSize: 11, letterSpacing: 1.4, color: AppColors.muted)),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              routine.isEnabled && target != null
                  ? TimeUtils.countdown(target - nowMs)
                  : '--:--',
              style: kCountdownStyle.copyWith(fontSize: 52),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              TimeUtils.scheduleSummary(
                mode: routine.scheduleMode,
                atTime: routine.atTime,
                intervalHours: routine.intervalHours,
                intervalMinutes: routine.intervalMinutes,
                weekdaysMask: routine.weekdaysMask,
                oneShotAt: routine.oneShotAt,
              ),
              style: const TextStyle(color: AppColors.muted),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text('Som: ${routine.soundLabel ?? _soundName(routine.soundSourceId)}',
                style: const TextStyle(color: AppColors.muted, fontSize: 12.5)),
          ),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () =>
                    ref.read(repositoryProvider).setEnabled(routine, !routine.isEnabled),
                child: Text(routine.isEnabled ? 'Pausar' : 'Ativar'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => FireScreen(routine: routine, type: type))),
                child: const Text('Disparar agora'),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () async {
              await ref.read(repositoryProvider).restartFromNow(routine);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contagem reiniciada a partir de agora')),
                );
              }
            },
            icon: const Icon(Icons.restart_alt, size: 18),
            label: const Text('Reiniciar contagem agora'),
          ),
          const SizedBox(height: 20),
          const Text('ÚLTIMOS DISPAROS',
              style: TextStyle(fontSize: 11, letterSpacing: 1.4, color: AppColors.faint)),
          const SizedBox(height: 6),
          if (logs.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('Nenhum disparo ainda', style: TextStyle(color: AppColors.faint)),
            ),
          for (final l in logs) _LogLine(log: l),
        ],
      ),
    );
  }

  Future<void> _confirmArchive(BuildContext context, WidgetRef ref, Routine r) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Arquivar rotina?'),
        content: Text('"${r.name}" será removida da lista.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Arquivar')),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(repositoryProvider).archive(r);
      if (context.mounted) Navigator.pop(context);
    }
  }

  String _soundName(int id) => switch (id) {
        2 => 'Música do celular',
        3 => 'Spotify',
        _ => 'Alarme padrão',
      };
}

class _LogLine extends ConsumerWidget {
  const _LogLine({required this.log});
  final TriggerLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (icon, label, color) = switch (log.statusId) {
      3 => ('✓', 'feito', AppColors.good),
      4 => ('⏰', 'soneca', AppColors.warn),
      5 => ('✗', 'perdido', AppColors.bad),
      _ => ('•', 'agendado', AppColors.muted),
    };
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.line))),
      child: Row(children: [
        Text(icon),
        const SizedBox(width: 9),
        Text(TimeUtils.clock(log.scheduledAt),
            style: const TextStyle(fontFamily: kMonoFont, fontSize: 13)),
        const Spacer(),
        Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
