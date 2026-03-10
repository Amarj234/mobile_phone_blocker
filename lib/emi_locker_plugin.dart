
import 'emi_locker_plugin_platform_interface.dart';

export 'device_control.dart';
export 'emi_locker.dart';
export 'emi_service.dart';
export 'lock_screen.dart';

class EmiLockerPlugin {
  Future<String?> getPlatformVersion() {
    return EmiLockerPluginPlatform.instance.getPlatformVersion();
  }
}
