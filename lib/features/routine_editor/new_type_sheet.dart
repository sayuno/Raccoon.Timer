import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database.dart';
import '../../data/providers.dart';
import '../../theme/app_theme.dart';

/// Bottom sheet to create a user-defined routine type (Option A: inline from
/// the editor). Returns the new type's id via [Navigator.pop].
class NewTypeSheet extends ConsumerStatefulWidget {
  const NewTypeSheet({super.key});

  @override
  ConsumerState<NewTypeSheet> createState() => _NewTypeSheetState();
}

class _NewTypeSheetState extends ConsumerState<NewTypeSheet> {
  final _name = TextEditingController();
  String _icon = '🧘';
  String _color = '#A78BFA';

  static const _icons = [
    '😀', '💊', '🧘', '🥗', '☕', '🚿',
    '🐶', '💼', '📞', '🌙', '🎧', '🧴',
    '🏃', '📖', '💧', '🎮', '🛏', '🍎',
  ];
  static const _colors = [
    '#38BDF8', '#A78BFA', '#F5C542', '#34D399', '#F87171', '#F472B6', '#94A3B8',
  ];

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    final slug = 'user_${DateTime.now().millisecondsSinceEpoch}';
    final id = await ref.read(repositoryProvider).createType(
          RoutineTypesCompanion.insert(
            name: slug,
            labelPt: name,
            icon: _icon,
            color: _color,
            isSystem: const Value(false),
          ),
        );
    if (mounted) Navigator.pop(context, id);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.line)),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38, height: 4,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                    color: AppColors.line, borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const Text('Novo tipo',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 14),
            const _MiniLabel('Nome'),
            TextField(
              controller: _name,
              autofocus: true,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(hintText: 'Vitamina'),
            ),
            const SizedBox(height: 16),
            const _MiniLabel('Ícone'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final e in _icons)
                  GestureDetector(
                    onTap: () => setState(() => _icon = e),
                    child: Container(
                      width: 42, height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _icon == e ? const Color(0xFF0E2430) : AppColors.bg,
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: _icon == e ? AppColors.cyan : AppColors.line),
                      ),
                      child: Text(e, style: const TextStyle(fontSize: 19)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const _MiniLabel('Cor'),
            Row(
              children: [
                for (final c in _colors)
                  GestureDetector(
                    onTap: () => setState(() => _color = c),
                    child: Container(
                      width: 30, height: 30,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _hex(c),
                        border: Border.all(
                          color: _color == c ? Colors.white : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: _name.text.trim().isEmpty ? null : _create,
              child: const Text('Criar tipo'),
            ),
          ],
        ),
      ),
    );
  }

  static Color _hex(String h) => Color(int.parse('FF${h.substring(1)}', radix: 16));
}

class _MiniLabel extends StatelessWidget {
  const _MiniLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Text(text.toUpperCase(),
            style: const TextStyle(fontSize: 11, letterSpacing: 1.1, color: AppColors.muted)),
      );
}
