// here we have the settings for prod
const String _prodUrl = 'plateaumed.com';

// here we have the settings for dev
const String _devUrl = 'dev.plateaumed.com';

class AppConfig {
  AppConfig();

  // Given we cannot switch between live and dev in the live-app
  // it should be done manually here instead.
  static bool isProd = false;

  static int storeCacheDebounceSeconds = 3;

  static int profilePictureTimestamp = DateTime.now().millisecondsSinceEpoch;

  static String versionNumber = '0.0.1 (1)';

  static String get apiProtocol {
    return AppConfig.isProd ? 'https' : 'https';
  }

  static String get apiDomain {
    return AppConfig.isProd ? _prodUrl : _devUrl;
  }

  static String apiPath(String path) {
    return '/api/v1/' + (path.startsWith('/') ? path.substring(1) : path);
  }

  static String apiFullPath(String path) {
    return AppConfig.apiProtocol +
        '://' +
        AppConfig.apiDomain +
        '/api/v1/' +
        (path.startsWith('/') ? path.substring(1) : path);
  }
}
