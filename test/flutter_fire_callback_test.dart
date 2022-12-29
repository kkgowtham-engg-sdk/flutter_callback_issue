import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_fire_callback/my_platform_plugin.dart';
import 'package:flutter_fire_callback/my_method_channel.dart';
import 'package:flutter_fire_callback/my_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterFireCallbackPlatform
    with MockPlatformInterfaceMixin
    implements MyPlatformInterface {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  void configure() {
  }

  @override
  void setPushClickCallBack(PushClickCallBack pushClickCallBack) {
  }
}

void main() {
  final MyPlatformInterface initialPlatform = MyPlatformInterface.instance;

  test('$MyMethodChannelCallBack is the default instance', () {
    expect(initialPlatform, isInstanceOf<MyMethodChannelCallBack>());
  });

  test('getPlatformVersion', () async {
    MyPlatformPlugin flutterFireCallbackPlugin = MyPlatformPlugin();
    MockFlutterFireCallbackPlatform fakePlatform = MockFlutterFireCallbackPlatform();
    MyPlatformInterface.instance = fakePlatform;

    expect(await flutterFireCallbackPlugin.getPlatformVersion(), '42');
  });
}
