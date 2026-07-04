import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/time_utils.dart';
import '../../data/database.dart';
import '../../data/providers.dart';
import '../../theme/app_theme.dart';
import '../routine_detail/routine_detail_screen.dart';
import '../routine_editor/routine_editor_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appStartupProvider); // one-time: permissions + reschedule
    final routinesAsync = ref.watch(routinesProvider);
    final typesAsync = ref.watch(typesProvider);
    final nowMs = ref.watch(tickerProvider).value ?? DateTime.now().millisecondsSinceEpoch;
    final types = typesAsync.value ?? const {};

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Raccoon ', style: TextStyle(fontWeight: FontWeight.w700)),
            Text('Timer', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.gold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.cyan,
        foregroundColor: const Color(0xFF04222F),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const RoutineEditorScreen())),
        child: const Icon(Icons.add),
      ),
      body: routinesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (routines) {
          if (routines.isEmpty) return const _EmptyState();
          final next = routines.firstWhere(
            (r) => r.isEnabled && (r.snoozeUntil ?? r.nextTriggerAt) != null,
            orElse: () => routines.first,
          );
          final rest = routines.where((r) => r.id != next.id).toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              _HeroCard(routine: next, type: types[next.typeId], nowMs: nowMs),
              const SizedBox(height: 18),
              const _SectionLabel('Rotinas'),
              for (final r in rest)
                _RoutineCard(routine: r, type: types[r.typeId], nowMs: nowMs),
            ],
          );
        },
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.routine, required this.type, required this.nowMs});
  final Routine routine;
  final RoutineType? type;
  final int nowMs;

  @override
  Widget build(BuildContext context) {
    final off = !routine.isEnabled;
    final target = routine.snoozeUntil ?? routine.nextTriggerAt;
    final showCountdown = !off && target != null;
    return GestureDetector(
      onTap: () => _openDetail(context, routine),
      child: Opacity(
        opacity: off ? 0.6 : 1,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: off ? AppColors.line : const Color(0xFF5A4D1E)),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF20222A), Color(0xFF191B22)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                _TypeBadge(type: type, size: 38),
                const SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(routine.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  Text(off ? 'pausada' : 'próximo disparo',
                      style: const TextStyle(color: AppColors.muted, fontSize: 11.5)),
                ]),
              ]),
              const SizedBox(height: 12),
              Text(
                showCountdown ? TimeUtils.countdown(target - nowMs) : '--:--',
                style: kCountdownStyle.copyWith(
                  fontSize: 40,
                  color: off ? AppColors.faint : AppColors.gold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoutineCard extends ConsumerWidget {
  const _RoutineCard({required this.routine, required this.type, required this.nowMs});
  final Routine routine;
  final RoutineType? type;
  final int nowMs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final target = routine.snoozeUntil ?? routine.nextTriggerAt;
    final off = !routine.isEnabled;
    return Opacity(
      opacity: off ? 0.5 : 1,
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _openDetail(context, routine),
          onLongPress: () async {
            await ref.read(repositoryProvider).restartFromNow(routine);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${routine.name}: contagem reiniciada')),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              _TypeBadge(type: type, size: 34),
              const SizedBox(width: 11),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Flexible(
                      child: Text(routine.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    const SizedBox(width: 8),
                    _Tag(TimeUtils.scheduleSummary(
                      mode: routine.scheduleMode,
                      atTime: routine.atTime,
                      intervalHours: routine.intervalHours,
                      intervalMinutes: routine.intervalMinutes,
                      weekdaysMask: routine.weekdaysMask,
                      oneShotAt: routine.oneShotAt,
                    )),
                  ]),
                  const SizedBox(height: 3),
                  Text(
                    off ? 'pausado' : TimeUtils.untilLabel(target, nowMs: nowMs),
                    style: TextStyle(
                      fontFamily: kMonoFont,
                      fontSize: 12,
                      color: off ? AppColors.faint : AppColors.cyan,
                    ),
                  ),
                ]),
              ),
              Switch(
                value: routine.isEnabled,
                activeThumbColor: AppColors.cyan,
                onChanged: (v) => ref.read(repositoryProvider).setEnabled(routine, v),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

void _openDetail(BuildContext context, Routine r) {
  Navigator.push(context,
      MaterialPageRoute(builder: (_) => RoutineDetailScreen(routineId: r.id)));
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.type, required this.size});
  final RoutineType? type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF0D1017),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: Text(type?.icon ?? '⏰', style: TextStyle(fontSize: size * 0.5)),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0F15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: Text(text, style: const TextStyle(fontSize: 10, color: AppColors.muted)),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 10),
      child: Text(text.toUpperCase(),
          style: const TextStyle(
              fontSize: 11, letterSpacing: 1.6, color: AppColors.faint)),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('⏰', style: TextStyle(fontSize: 56)),
        SizedBox(height: 12),
        Text('Nenhuma rotina ainda', style: TextStyle(color: AppColors.muted)),
        SizedBox(height: 6),
        Text('Toque em + para criar', style: TextStyle(color: AppColors.faint, fontSize: 13)),
      ]),
    );
  }
}
