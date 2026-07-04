import 'package:drift/drift.dart' show Value;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/schedule.dart';
import '../../data/database.dart';
import '../../data/providers.dart';
import '../../services/spotify_service.dart';
import '../../theme/app_theme.dart';
import 'new_type_sheet.dart';
import 'spotify_track_sheet.dart';

class RoutineEditorScreen extends ConsumerStatefulWidget {
  const RoutineEditorScreen({super.key, this.existing});
  final Routine? existing;

  @override
  ConsumerState<RoutineEditorScreen> createState() => _RoutineEditorScreenState();
}

class _RoutineEditorScreenState extends ConsumerState<RoutineEditorScreen> {
  late final TextEditingController _name;
  int? _typeId;
  ScheduleMode _mode = ScheduleMode.daily;
  TimeOfDay _dailyTime = TimeOfDay.now();
  int _weekdaysMask = 0; // 0 = every day
  int _intervalHours = 2;
  int _intervalMinutes = 0;
  DateTime? _oneShotAt;
  int _soundSourceId = 1;
  String? _soundRef;
  String? _soundLabel;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?.name ?? '');
    if (e != null) {
      _typeId = e.typeId;
      _mode = ScheduleMode.fromValue(e.scheduleMode);
      _weekdaysMask = e.weekdaysMask ?? 0;
      _intervalHours = e.intervalHours ?? 2;
      _intervalMinutes = e.intervalMinutes ?? 0;
      _soundSourceId = e.soundSourceId;
      _soundRef = e.soundRef;
      _soundLabel = e.soundLabel;
      if (e.atTime != null) {
        final parts = e.atTime!.split(':');
        _dailyTime = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      }
      if (e.oneShotAt != null) {
        _oneShotAt = DateTime.fromMillisecondsSinceEpoch(e.oneShotAt!);
      }
    }
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  bool get _canSave =>
      _name.text.trim().isNotEmpty &&
      _typeId != null &&
      (_mode != ScheduleMode.oneShot || _oneShotAt != null);

  Future<void> _save() async {
    final draft = RoutinesCompanion(
      id: widget.existing == null ? const Value.absent() : Value(widget.existing!.id),
      name: Value(_name.text.trim()),
      typeId: Value(_typeId!),
      scheduleMode: Value(_mode.value),
      atTime: Value(_mode == ScheduleMode.daily ? _fmtTod(_dailyTime) : null),
      oneShotAt: Value(_mode == ScheduleMode.oneShot ? _oneShotAt?.millisecondsSinceEpoch : null),
      intervalHours: Value(_mode == ScheduleMode.interval ? _intervalHours : null),
      intervalMinutes: Value(_mode == ScheduleMode.interval ? _intervalMinutes : null),
      // Weekday filter only belongs to daily mode; never leak it to interval/one-shot.
      weekdaysMask:
          Value(_mode == ScheduleMode.daily && _weekdaysMask != 0 ? _weekdaysMask : null),
      soundSourceId: Value(_soundSourceId),
      soundRef: Value(_soundRef),
      soundLabel: Value(_soundLabel),
      isEnabled: const Value(true),
    );
    await ref.read(repositoryProvider).saveRoutine(draft, id: widget.existing?.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final types = ref.watch(typesProvider).value ?? const {};
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing == null ? 'Nova rotina' : 'Editar rotina'),
        actions: [
          TextButton(
            onPressed: _canSave ? _save : null,
            child: Text('Salvar',
                style: TextStyle(
                    color: _canSave ? AppColors.gold : AppColors.faint,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          const _Label('Nome'),
          TextField(
            controller: _name,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(hintText: 'Beber água'),
          ),
          const SizedBox(height: 18),
          const _Label('Tipo'),
          _TypeChips(
            types: types.values.toList(),
            selected: _typeId,
            onSelect: (id) => setState(() => _typeId = id),
            onNew: _openNewType,
          ),
          const SizedBox(height: 18),
          const _Label('Quando'),
          _WhenPicker(
            mode: _mode,
            onMode: (m) => setState(() => _mode = m),
            dailyTime: _dailyTime,
            onDailyTime: () async {
              final t = await showTimePicker(context: context, initialTime: _dailyTime);
              if (t != null) setState(() => _dailyTime = t);
            },
            weekdaysMask: _weekdaysMask,
            onToggleDay: (wd) => setState(() => _weekdaysMask = Weekdays.toggle(_weekdaysMask, wd)),
            intervalHours: _intervalHours,
            intervalMinutes: _intervalMinutes,
            onInterval: (h, m) => setState(() { _intervalHours = h; _intervalMinutes = m; }),
            oneShotAt: _oneShotAt,
            onPickOneShot: _pickOneShot,
          ),
          const SizedBox(height: 18),
          const _Label('Som ao disparar'),
          _SoundPicker(
            sourceId: _soundSourceId,
            soundLabel: _soundLabel,
            spotifyConnected: ref.watch(spotifyConnectedProvider).value ?? false,
            onSource: (id) => setState(() => _soundSourceId = id),
            onPickLocal: _pickLocalSound,
            onPickSpotify: _pickSpotifyTrack,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _canSave ? _save : null,
            style: FilledButton.styleFrom(
                backgroundColor: AppColors.gold, foregroundColor: const Color(0xFF3A2F06)),
            child: const Text('Salvar rotina'),
          ),
        ],
      ),
    );
  }

  Future<void> _openNewType() async {
    final newId = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NewTypeSheet(),
    );
    if (newId != null) setState(() => _typeId = newId);
  }

  Future<void> _pickOneShot() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _oneShotAt ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 3650)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(_oneShotAt ?? now));
    if (time == null) return;
    setState(() => _oneShotAt =
        DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  Future<void> _pickLocalSound() async {
    final res = await FilePicker.pickFiles(type: FileType.audio);
    if (res == null || res.files.isEmpty) return;
    setState(() {
      _soundSourceId = 2;
      _soundRef = res.files.single.path;
      _soundLabel = res.files.single.name;
    });
  }

  Future<void> _pickSpotifyTrack() async {
    final track = await showModalBottomSheet<SpotifyTrack>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SpotifyTrackSheet(),
    );
    if (track == null) return;
    setState(() {
      _soundSourceId = 3;
      _soundRef = track.uri;
      _soundLabel = track.label;
    });
  }

  String _fmtTod(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

// --- sub widgets -----------------------------------------------------------

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text.toUpperCase(),
            style: const TextStyle(fontSize: 11, letterSpacing: 1.1, color: AppColors.muted)),
      );
}

class _TypeChips extends StatelessWidget {
  const _TypeChips(
      {required this.types, required this.selected, required this.onSelect, required this.onNew});
  final List<RoutineType> types;
  final int? selected;
  final ValueChanged<int> onSelect;
  final VoidCallback onNew;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 8, children: [
      for (final t in types)
        _Chip(
          label: t.icon,
          selected: t.id == selected,
          onTap: () => onSelect(t.id),
        ),
      _Chip(label: '+', selected: false, dashed: true, onTap: onNew),
    ]);
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap, this.dashed = false});
  final String label;
  final bool selected;
  final bool dashed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0E2430) : AppColors.surface,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: selected || dashed ? AppColors.cyan : AppColors.line,
          ),
        ),
        child: Text(label,
            style: TextStyle(fontSize: 19, color: dashed ? AppColors.cyan : null)),
      ),
    );
  }
}

class _WhenPicker extends StatelessWidget {
  const _WhenPicker({
    required this.mode,
    required this.onMode,
    required this.dailyTime,
    required this.onDailyTime,
    required this.weekdaysMask,
    required this.onToggleDay,
    required this.intervalHours,
    required this.intervalMinutes,
    required this.onInterval,
    required this.oneShotAt,
    required this.onPickOneShot,
  });

  final ScheduleMode mode;
  final ValueChanged<ScheduleMode> onMode;
  final TimeOfDay dailyTime;
  final VoidCallback onDailyTime;
  final int weekdaysMask;
  final ValueChanged<int> onToggleDay;
  final int intervalHours;
  final int intervalMinutes;
  final void Function(int, int) onInterval;
  final DateTime? oneShotAt;
  final VoidCallback onPickOneShot;

  static const _wd = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _Radio(
        selected: mode == ScheduleMode.daily,
        onTap: () => onMode(ScheduleMode.daily),
        child: Row(children: [
          const Text('Todo dia às'),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              onMode(ScheduleMode.daily);
              onDailyTime();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF0C0F15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.cyan),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  '${dailyTime.hour.toString().padLeft(2, '0')}:${dailyTime.minute.toString().padLeft(2, '0')}',
                  style: kCountdownStyle.copyWith(fontSize: 18),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.schedule, size: 16, color: AppColors.cyan),
              ]),
            ),
          ),
        ]),
      ),
      if (mode == ScheduleMode.daily)
        Padding(
          padding: const EdgeInsets.only(left: 27, top: 8, bottom: 4),
          child: Row(children: [
            for (var i = 0; i < 7; i++)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: _DayToggle(
                  label: _wd[i],
                  on: weekdaysMask == 0 || (weekdaysMask & (1 << i)) != 0,
                  onTap: () => onToggleDay(i + 1),
                ),
              ),
          ]),
        ),
      _Radio(
        selected: mode == ScheduleMode.interval,
        onTap: () => onMode(ScheduleMode.interval),
        child: const Text('A cada intervalo'),
      ),
      if (mode == ScheduleMode.interval)
        Padding(
          padding: const EdgeInsets.only(left: 27, top: 8),
          child: Row(children: [
            _Stepper(value: intervalHours, unit: 'horas', onChanged: (v) => onInterval(v, intervalMinutes)),
            const SizedBox(width: 10),
            _Stepper(value: intervalMinutes, unit: 'min', step: 5, max: 55, onChanged: (v) => onInterval(intervalHours, v)),
          ]),
        ),
      _Radio(
        selected: mode == ScheduleMode.oneShot,
        onTap: () => onMode(ScheduleMode.oneShot),
        child: Row(children: [
          const Text('Data e hora única'),
          const Spacer(),
          TextButton(
            onPressed: onPickOneShot,
            child: Text(
              oneShotAt == null
                  ? 'escolher'
                  : '${oneShotAt!.day}/${oneShotAt!.month} ${oneShotAt!.hour.toString().padLeft(2, '0')}:${oneShotAt!.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(color: AppColors.cyan),
            ),
          ),
        ]),
      ),
    ]);
  }
}

class _Radio extends StatelessWidget {
  const _Radio({required this.selected, required this.onTap, required this.child});
  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0E2430) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.cyan : AppColors.line),
        ),
        child: Row(children: [
          Container(
            width: 17,
            height: 17,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: selected ? AppColors.cyan : AppColors.faint, width: 2),
            ),
            child: selected
                ? Center(
                    child: Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.cyan)))
                : null,
          ),
          Expanded(child: child),
        ]),
      ),
    );
  }
}

class _DayToggle extends StatelessWidget {
  const _DayToggle({required this.label, required this.on, required this.onTap});
  final String label;
  final bool on;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: on ? const Color(0xFF0E2430) : AppColors.surface,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: on ? AppColors.cyan : AppColors.line),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: on ? AppColors.cyan : AppColors.muted)),
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({required this.value, required this.unit, required this.onChanged, this.step = 1, this.max = 23});
  final int value;
  final String unit;
  final ValueChanged<int> onChanged;
  final int step;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        _sqBtn(Icons.remove, () => onChanged((value - step).clamp(0, max))),
        Container(
          width: 54,
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          child: Text(value.toString().padLeft(2, '0'),
              style: kCountdownStyle.copyWith(fontSize: 20)),
        ),
        _sqBtn(Icons.add, () => onChanged((value + step).clamp(0, max))),
      ]),
      Text(unit, style: const TextStyle(fontSize: 9, color: AppColors.muted)),
    ]);
  }

  Widget _sqBtn(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF0C0F15),
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: AppColors.line),
          ),
          child: Icon(icon, size: 16, color: AppColors.cyan),
        ),
      );
}

class _SoundPicker extends StatelessWidget {
  const _SoundPicker(
      {required this.sourceId,
      required this.soundLabel,
      required this.spotifyConnected,
      required this.onSource,
      required this.onPickLocal,
      required this.onPickSpotify});
  final int sourceId;
  final String? soundLabel;
  final bool spotifyConnected;
  final ValueChanged<int> onSource;
  final VoidCallback onPickLocal;
  final VoidCallback onPickSpotify;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _Radio(
        selected: sourceId == 1,
        onTap: () => onSource(1),
        child: const Text('Alarme padrão'),
      ),
      _Radio(
        selected: sourceId == 2,
        onTap: onPickLocal,
        child: Row(children: [
          const Text('🎵 Música do celular'),
          if (soundLabel != null) ...[
            const SizedBox(width: 6),
            Flexible(
              child: Text(soundLabel!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.muted, fontSize: 12)),
            ),
          ],
        ]),
      ),
      Opacity(
        opacity: spotifyConnected ? 1 : 0.42,
        child: _Radio(
          selected: sourceId == 3,
          onTap: spotifyConnected ? onPickSpotify : () {},
          child: Row(children: [
            const Text('Spotify'),
            const SizedBox(width: 6),
            if (spotifyConnected && sourceId == 3 && soundLabel != null)
              Flexible(
                child: Text(soundLabel!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.muted, fontSize: 12)),
              )
            else
              Text(
                spotifyConnected ? 'buscar faixa' : 'Conecte nos Ajustes',
                style: const TextStyle(color: AppColors.muted, fontSize: 10),
              ),
          ]),
        ),
      ),
    ]);
  }
}
