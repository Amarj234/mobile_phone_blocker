import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'emi_locker_plugin_method_channel.dart';

abstract class EmiLockerPluginPlatform extends PlatformInterface {
  /// Constructs a EmiLockerPluginPlatform.
  EmiLockerPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static EmiLockerPluginPlatform _instance = MethodChannelEmiLockerPlugin();

  /// The default instance of [EmiLockerPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelEmiLockerPlugin].
  static EmiLockerPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EmiLockerPluginPlatform] when
  /// they register themselves.
  static set instance(EmiLockerPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
