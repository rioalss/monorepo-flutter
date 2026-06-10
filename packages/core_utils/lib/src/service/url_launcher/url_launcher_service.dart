// ignore_for_file: document_ignores, comment_references

import 'package:core_utils/src/helpers/logger.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:url_launcher/url_launcher.dart' show LaunchMode;

/// Facade over [url_launcher] for opening URLs, phone, email, and maps.
///
/// Returns `true` when the target was launched successfully, `false` otherwise.
/// Normal launch failures are logged and do not throw.
///
/// Example:
/// ```dart
/// await UrlLauncherService.launchPhone('+6281234567890');
/// await UrlLauncherService.launchExternal('https://example.com');
/// ```
abstract final class UrlLauncherService {
  UrlLauncherService._();

  /// Whether the given [url] can be handled by the platform.
  static Future<bool> canLaunch(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return false;
    }
    return launcher.canLaunchUrl(uri);
  }

  /// Launches [url] using the given [mode].
  static Future<bool> launchUrl(
    String url, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      AppLogger.w('UrlLauncherService.launchUrl: invalid url "$url"');
      return false;
    }
    return launchUri(uri, mode: mode);
  }

  /// Launches [uri] using the given [mode].
  static Future<bool> launchUri(
    Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      if (!await launcher.canLaunchUrl(uri)) {
        AppLogger.w('UrlLauncherService.launchUri: cannot launch $uri');
        return false;
      }
      return await launcher.launchUrl(uri, mode: mode);
    } on Object catch (error, stackTrace) {
      AppLogger.e('UrlLauncherService.launchUri failed', error, stackTrace);
      return false;
    }
  }

  /// Opens the dialer with [phone] (digits and optional leading `+`).
  static Future<bool> launchPhone(String phone) {
    final normalized = phone.replaceAll(RegExp(r'[^\d+]'), '');
    if (normalized.isEmpty) {
      AppLogger.w('UrlLauncherService.launchPhone: empty phone number');
      return Future.value(false);
    }
    return launchUri(Uri(scheme: 'tel', path: normalized));
  }

  /// Opens the default mail client.
  static Future<bool> launchEmail({
    required String email,
    String? subject,
    String? body,
  }) {
    if (email.isEmpty) {
      AppLogger.w('UrlLauncherService.launchEmail: empty email');
      return Future.value(false);
    }

    return launchUri(
      Uri(
        scheme: 'mailto',
        path: email,
        query: _encodeQuery({
          if (subject != null && subject.isNotEmpty) 'subject': subject,
          if (body != null && body.isNotEmpty) 'body': body,
        }),
      ),
    );
  }

  /// Opens Google Maps at the given coordinates (cross-platform).
  static Future<bool> launchMaps({
    required double latitude,
    required double longitude,
    String? label,
  }) {
    final query = label != null && label.isNotEmpty
        ? '$latitude,$longitude($label)'
        : '$latitude,$longitude';

    return launchUri(
      Uri.https(
        'www.google.com',
        '/maps/search/',
        {'api': '1', 'query': query},
      ),
      mode: launcher.LaunchMode.externalApplication,
    );
  }

  /// Opens [url] in an external application (browser, maps, etc.).
  static Future<bool> launchExternal(String url) => launchUrl(
        url,
        mode: launcher.LaunchMode.externalApplication,
      );

  static String? _encodeQuery(Map<String, String> params) {
    if (params.isEmpty) {
      return null;
    }
    return params.entries
        .map(
          (entry) =>
              '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}',
        )
        .join('&');
  }
}
