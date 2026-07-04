import 'dart:async';

import 'package:flutter/material.dart';

import '../../services/spotify_service.dart';
import '../../theme/app_theme.dart';

/// Bottom sheet: search Spotify tracks and pick one. Returns the [SpotifyTrack].
class SpotifyTrackSheet extends StatefulWidget {
  const SpotifyTrackSheet({super.key});

  @override
  State<SpotifyTrackSheet> createState() => _SpotifyTrackSheetState();
}

class _SpotifyTrackSheetState extends State<SpotifyTrackSheet> {
  final _query = TextEditingController();
  Timer? _debounce;
  bool _loading = false;
  List<SpotifyTrack> _results = const [];

  @override
  void dispose() {
    _debounce?.cancel();
    _query.dispose();
    super.dispose();
  }

  void _onChanged(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () => _run(q));
  }

  Future<void> _run(String q) async {
    if (q.trim().isEmpty) {
      setState(() => _results = const []);
      return;
    }
    setState(() => _loading = true);
    final res = await SpotifyService.instance.search(q);
    if (mounted) {
      setState(() {
        _results = res;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.line)),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
        child: Column(
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
            const Text('Buscar faixa no Spotify',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 12),
            TextField(
              controller: _query,
              autofocus: true,
              onChanged: _onChanged,
              decoration: const InputDecoration(
                hintText: 'nome da música ou artista',
                prefixIcon: Icon(Icons.search, color: AppColors.muted),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _results.isEmpty
                      ? const Center(
                          child: Text('Digite pra buscar',
                              style: TextStyle(color: AppColors.faint)))
                      : ListView.separated(
                          itemCount: _results.length,
                          separatorBuilder: (_, _) =>
                              const Divider(color: AppColors.line, height: 1),
                          itemBuilder: (_, i) {
                            final t = _results[i];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.music_note, color: AppColors.good),
                              title: Text(t.name,
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                              subtitle: Text(t.artist,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: AppColors.muted)),
                              onTap: () => Navigator.pop(context, t),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
