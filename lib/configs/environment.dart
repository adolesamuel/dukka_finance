import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

bool freePass = false;

// ignore: avoid_classes_with_only_static_members
class Environment {
  // final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  ///This can be either development, staging, production or Unknown
  static String environment = 'Unknown';

  factory Environment() {
    return _instance;
  }

  Environment._privateConstructor();

  static final Environment _instance = Environment._privateConstructor();

  static String fileName(PackageInfo packageInfo) {
    final String packageName = packageInfo.packageName;
    if (packageName == 'ng.sendme.farmer') {
      environment = 'production';
      return '.env.production';
    } else if (packageName == 'ng.sendme.farmer_staging' ||
        packageName == 'ng.sendme.farmer.staging') {
      environment = 'staging';
      return '.env.staging';
    } else {
      environment = 'development';
      return '.env';
    }
  }

  static String get baseUrl {
    return dotenv.env['BASE_URL'] ?? 'API Url not found!';
  }
}
