import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emi_locker_plugin/emi_locker_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelEmiLockerPlugin platform = MethodChannelEmiLockerPlugin();
  const MethodChannel channel = MethodChannel('emi_locker_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
