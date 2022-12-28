import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_fire_callback/flutter_fire_callback.dart';
import 'package:flutter_fire_callback/flutter_fire_callback_platform_interface.dart';
import 'package:flutter_fire_callback/flutter_fire_callback_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterFireCallbackPlatform
    with MockPlatformInterfaceMixin
    implements FlutterFireCallbackPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterFireCallbackPlatform initialPlatform = FlutterFireCallbackPlatform.instance;

  test('$MethodChannelFlutterFireCallback is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFireCallback>());
  });

  test('getPlatformVersion', () async {
    FlutterFireCallback flutterFireCallbackPlugin = FlutterFireCallback();
    MockFlutterFireCallbackPlatform fakePlatform = MockFlutterFireCallbackPlatform();
    FlutterFireCallbackPlatform.instance = fakePlatform;

    expect(await flutterFireCallbackPlugin.getPlatformVersion(), '42');
  });
}
