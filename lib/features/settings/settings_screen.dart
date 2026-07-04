import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../services/notification_service.dart';
import '../../services/spotify_service.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _spotifyConnected = false;
  bool _exactOk = true;
  int _pending = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = ref.read(databaseProvider);
    final v = await db.getSetting('spotify_connected');
    final exact = await NotificationService.instance.exactAlarmsAllowed();
    final pending = await NotificationService.instance.pendingCount();
    if (mounted) {
      setState(() {
        _spotifyConnected = v == '1';
        _exactOk = exact;
        _pending = pending;
      });
    }
  }

  Future<void> _grantPermissions() async {
    await NotificationService.instance.requestPermissions();
    await _load();
  }

  bool _busy = false;

  Future<void> _toggleSpotify() async {
    final db = ref.read(databaseProvider);
    setState(() => _busy = true);
    try {
      if (_spotifyConnected) {
        await SpotifyService.instance.disconnect();
        await db.setSetting('spotify_connected', '0');
        if (mounted) setState(() => _spotifyConnected = false);
      } else {
        final ok = await SpotifyService.instance.connect();
        await db.setSetting('spotify_connected', ok ? '1' : '0');
        if (mounted) {
          setState(() => _spotifyConnected = ok);
          if (!ok) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Falha ao conectar. O app do Spotify está instalado e logado?'),
            ));
          }
        }
      }
      ref.invalidate(spotifyConnectedProvider);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
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
          _SpotifyRow(connected: _spotifyConnected, busy: _busy, onTap: _busy ? null : _toggleSpotify),
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
            subtitle: Text(
              _exactOk ? 'Concedido' : 'Necessário para o alarme tocar na hora',
              style: TextStyle(color: _exactOk ? AppColors.good : AppColors.bad, fontSize: 12),
            ),
            trailing: _exactOk
                ? const Icon(Icons.check, color: AppColors.good)
                : const Icon(Icons.chevron_right, color: AppColors.gold),
            onTap: _grantPermissions,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Alarmes agendados'),
            subtitle: const Text('Diagnóstico', style: TextStyle(color: AppColors.muted, fontSize: 12)),
            trailing: Text('$_pending', style: const TextStyle(fontFamily: kMonoFont, color: AppColors.cyan)),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0x22F5C542),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF5A4D1E)),
            ),
            child: const Text(
              '⚠️ Xiaomi / HyperOS mata apps em segundo plano. Para o alarme tocar '
              'com o app fechado ou tela travada, ative nas configurações do sistema:\n'
              '• Autostart / Início automático: LIGADO\n'
              '• Economia de bateria do app: SEM RESTRIÇÕES\n'
              '• Trave o app na tela de recentes (cadeado)\n'
              '• Notificações na tela de bloqueio: PERMITIR',
              style: TextStyle(color: AppColors.text, fontSize: 12.5, height: 1.5),
            ),
          ),
          const SizedBox(height: 24),
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
  const _SpotifyRow({required this.connected, required this.busy, required this.onTap});
  final bool connected;
  final bool busy;
  final VoidCallback? onTap;

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
          child: busy
              ? const SizedBox(
                  width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(connected ? 'Desconectar' : 'Conectar'),
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
