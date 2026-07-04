import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../services/notification_service.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _spotifyConnected = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = ref.read(databaseProvider);
    final v = await db.getSetting('spotify_connected');
    if (mounted) setState(() => _spotifyConnected = v == '1');
  }

  Future<void> _toggleSpotify() async {
    // Real OAuth via the Spotify App Remote SDK lands later; this flips the UI
    // flag so the editor can offer Spotify track search once connected.
    final db = ref.read(databaseProvider);
    final next = !_spotifyConnected;
    await db.setSetting('spotify_connected', next ? '1' : '0');
    ref.invalidate(spotifyConnectedProvider);
    setState(() => _spotifyConnected = next);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const _Group('Aparência'),
          const _Row(label: 'Tema', value: 'Escuro'),
          const _Row(label: 'Formato de hora', value: '24h'),
          const _Group('Padrões'),
          const _Row(label: 'Soneca padrão', value: '5 min'),
          const _Row(label: 'Som padrão', value: 'Alarme 1'),
          const _Group('Contas'),
          _SpotifyRow(connected: _spotifyConnected, onTap: _toggleSpotify),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Conecte 1× — depois as rotinas podem buscar faixas. Requer Spotify Premium.',
              style: TextStyle(color: AppColors.muted, fontSize: 12, height: 1.5),
            ),
          ),
          const _Group('Permissões'),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Alarmes exatos e notificações'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.gold),
            onTap: () => NotificationService.instance.requestPermissions(),
          ),
        ],
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(2, 16, 2, 4),
        child: Text(text.toUpperCase(),
            style: const TextStyle(fontSize: 11, letterSpacing: 1.4, color: AppColors.faint)),
      );
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.line))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label),
        Text(value, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
      ]),
    );
  }
}

class _SpotifyRow extends StatelessWidget {
  const _SpotifyRow({required this.connected, required this.onTap});
  final bool connected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(children: [
        Container(
          width: 34, height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xFF0B3A24), borderRadius: BorderRadius.circular(10)),
          child: const Text('♫', style: TextStyle(color: AppColors.good, fontSize: 16)),
        ),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Spotify', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          _Pill(connected: connected),
        ]),
        const Spacer(),
        OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.good,
            side: const BorderSide(color: Color(0xFF1C5A3A)),
          ),
          child: Text(connected ? 'Desconectar' : 'Conectar'),
        ),
      ]),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.connected});
  final bool connected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: connected ? const Color(0xFF0B3A24) : const Color(0xFF2A1010),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        connected ? 'conectado' : 'desconectado',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: connected ? AppColors.good : AppColors.bad,
        ),
      ),
    );
  }
}
