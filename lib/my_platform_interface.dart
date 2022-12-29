import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_method_channel.dart';

abstract class MyPlatformInterface extends PlatformInterface {
  /// Constructs a SamplePlatformInterface.
  MyPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static MyPlatformInterface _instance = MyMethodChannelCallBack();

  /// The default instance of [MyPlatformInterface] to use.
  ///
  /// Defaults to [MyMethodChannelCallBack].
  static MyPlatformInterface get instance => _instance;

  static set instance(MyPlatformInterface instance) {
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
