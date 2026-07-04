/// Spotify app credentials (public client id — safe to ship; mobile uses PKCE,
/// no client secret). Registered at developer.spotify.com.
class SpotifyConfig {
  static const clientId = 'd8b1c9133b4647e9b46d0ef3a142c24e';
  static const redirectUrl = 'raccoontimer://callback';

  /// Scopes: control playback + read current state.
  static const scope = 'app-remote-control,streaming,user-read-playback-state';
}
