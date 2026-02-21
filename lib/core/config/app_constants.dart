abstract class AppConstants {
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const String connectivityProbeUrl = 'https://www.gstatic.com/generate_204';
  static const Duration connectivityProbeTimeout = Duration(seconds: 3);
}
