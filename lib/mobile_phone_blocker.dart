
import 'mobile_phone_blocker_platform_interface.dart';

export 'device_control.dart';
export 'emi_locker.dart';
export 'emi_service.dart';
export 'lock_screen.dart';

class MobilePhoneBlocker {
  Future<String?> getPlatformVersion() {
    return MobilePhoneBlockerPlatform.instance.getPlatformVersion();
  }
}
