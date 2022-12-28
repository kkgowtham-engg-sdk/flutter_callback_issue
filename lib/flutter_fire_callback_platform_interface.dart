import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_fire_callback_method_channel.dart';

abstract class FlutterFireCallbackPlatform extends PlatformInterface {
  /// Constructs a FlutterFireCallbackPlatform.
  FlutterFireCallbackPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFireCallbackPlatform _instance = MethodChannelFlutterFireCallback();

  /// The default instance of [FlutterFireCallbackPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFireCallback].
  static FlutterFireCallbackPlatform get instance => _instance;

  static set instance(FlutterFireCallbackPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void configure(){
    throw UnimplementedError('configure() has not been implemented.');
  }

  void setPushClickCallBack(PushClickCallBack pushClickCallBack){
    throw UnimplementedError('configure() has not been implemented.');
  }
}
