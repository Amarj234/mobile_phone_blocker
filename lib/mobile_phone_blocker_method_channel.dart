import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mobile_phone_blocker_platform_interface.dart';

/// An implementation of [MobilePhoneBlockerPlatform] that uses method channels.
class MethodChannelMobilePhoneBlocker extends MobilePhoneBlockerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mobile_phone_blocker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
