import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_fire_callback_platform_interface.dart';
import 'dart:convert';

typedef PushClickCallBack = void Function(Map<String, dynamic> title);

/// An implementation of [FlutterFireCallbackPlatform] that uses method channels.
class MethodChannelFlutterFireCallback extends FlutterFireCallbackPlatform {

  PushClickCallBack? pushClickCallBack;
  MethodChannel? pushCallBackChannel;

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  late MethodChannel methodChannel =const MethodChannel('flutter_fire_callback');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void setPushClickCallBack(PushClickCallBack callback) {
    pushClickCallBack = callback;
  }

  ///This Method Call Handler Callback function only works when FirebaseMessage.onBackgroundMessage function is not used.
  Future _methodHandler(MethodCall call) async {
    print("_methodHandler :${call.method}");
    if (call.method == "onPushClick") {
      Map<String, dynamic> data = jsonDecode(call.arguments[0] as String);
      pushClickCallBack?.call(data);
    }
  }

  @override
  void configure(){
    pushCallBackChannel = const MethodChannel('com.example.flutter.callback.flutter_fire_callback/push');
    pushCallBackChannel?.setMethodCallHandler(_methodHandler);
  }
}
