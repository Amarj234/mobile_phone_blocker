import 'package:flutter_test/flutter_test.dart';
import 'package:emi_locker_plugin/emi_locker_plugin.dart';
import 'package:emi_locker_plugin/emi_locker_plugin_platform_interface.dart';
import 'package:emi_locker_plugin/emi_locker_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEmiLockerPluginPlatform
    with MockPlatformInterfaceMixin
    implements EmiLockerPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EmiLockerPluginPlatform initialPlatform = EmiLockerPluginPlatform.instance;

  test('$MethodChannelEmiLockerPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEmiLockerPlugin>());
  });

  test('getPlatformVersion', () async {
    EmiLockerPlugin emiLockerPlugin = EmiLockerPlugin();
    MockEmiLockerPluginPlatform fakePlatform = MockEmiLockerPluginPlatform();
    EmiLockerPluginPlatform.instance = fakePlatform;

    expect(await emiLockerPlugin.getPlatformVersion(), '42');
  });
}
