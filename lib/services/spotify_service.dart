import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_sdk/spotify_sdk.dart';

import '../config/spotify_config.dart';

/// A track picked for a routine.
class SpotifyTrack {
  const SpotifyTrack({required this.uri, required this.name, required this.artist});
  final String uri;
  final String name;
  final String artist;
  String get label => '$name — $artist';
}

/// Thin wrapper over spotify_sdk + Web API search. OAuth token lives in secure
/// storage (never in the DB).
class SpotifyService {
  SpotifyService._();
  static final SpotifyService instance = SpotifyService._();

  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'spotify_access_token';

  /// Opens the Spotify auth flow and stores the returned access token.
  /// Returns true on success.
  Future<bool> connect() async {
    try {
      final token = await SpotifySdk.getAccessToken(
        clientId: SpotifyConfig.clientId,
        redirectUrl: SpotifyConfig.redirectUrl,
        scope: SpotifyConfig.scope,
      );
      if (token.isEmpty) return false;
      await _storage.write(key: _tokenKey, value: token);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> disconnect() async {
    await _storage.delete(key: _tokenKey);
    try {
      await SpotifySdk.disconnect();
    } catch (_) {}
  }

  Future<String?> _token() => _storage.read(key: _tokenKey);

  /// Ensures we have a token, re-authing if needed.
  Future<String?> _ensureToken() async {
    final existing = await _token();
    if (existing != null && existing.isNotEmpty) return existing;
    return (await connect()) ? _token() : null;
  }

  /// Search tracks via the Spotify Web API.
  Future<List<SpotifyTrack>> search(String query) async {
    if (query.trim().isEmpty) return const [];
    final token = await _ensureToken();
    if (token == null) return const [];

    final uri = Uri.https('api.spotify.com', '/v1/search', {
      'q': query,
      'type': 'track',
      'limit': '20',
    });
    final res = await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 401) {
      // token expired → refresh once
      await _storage.delete(key: _tokenKey);
      final fresh = await _ensureToken();
      if (fresh == null) return const [];
      final retry = await http.get(uri, headers: {'Authorization': 'Bearer $fresh'});
      if (retry.statusCode != 200) return const [];
      return _parse(retry.body);
    }
    if (res.statusCode != 200) return const [];
    return _parse(res.body);
  }

  List<SpotifyTrack> _parse(String body) {
    final items = (jsonDecode(body)['tracks']?['items'] as List?) ?? const [];
    return items.map((t) {
      final artists = (t['artists'] as List?) ?? const [];
      final artist = artists.isNotEmpty ? (artists.first['name'] ?? '') : '';
      return SpotifyTrack(
        uri: t['uri'] ?? '',
        name: t['name'] ?? '',
        artist: artist,
      );
    }).where((t) => t.uri.isNotEmpty).toList();
  }

  /// Start playing a track/playlist uri via the connected Spotify app.
  Future<void> play(String spotifyUri) async {
    await SpotifySdk.connectToSpotifyRemote(
      clientId: SpotifyConfig.clientId,
      redirectUrl: SpotifyConfig.redirectUrl,
    );
    await SpotifySdk.play(spotifyUri: spotifyUri);
  }

  Future<void> stop() async {
    try {
      await SpotifySdk.pause();
    } catch (_) {}
  }
}
