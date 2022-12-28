
import 'flutter_fire_callback_method_channel.dart';
import 'flutter_fire_callback_platform_interface.dart';



class FlutterFireCallback {

  Future<String?> getPlatformVersion() {
    return FlutterFireCallbackPlatform.instance.getPlatformVersion();
  }

  void setPushClickCallBack(PushClickCallBack callback) {
    FlutterFireCallbackPlatform.instance.setPushClickCallBack(callback);
  }

  void init(){
    FlutterFireCallbackPlatform.instance.configure();
  }

}
