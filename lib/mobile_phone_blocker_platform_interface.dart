import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mobile_phone_blocker_method_channel.dart';

abstract class MobilePhoneBlockerPlatform extends PlatformInterface {
  /// Constructs a MobilePhoneBlockerPlatform.
  MobilePhoneBlockerPlatform() : super(token: _token);

  static final Object _token = Object();

  static MobilePhoneBlockerPlatform _instance = MethodChannelMobilePhoneBlocker();

  /// The default instance of [MobilePhoneBlockerPlatform] to use.
  ///
  /// Defaults to [MethodChannelMobilePhoneBlocker].
  static MobilePhoneBlockerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MobilePhoneBlockerPlatform] when
  /// they register themselves.
  static set instance(MobilePhoneBlockerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
