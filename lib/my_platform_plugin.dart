
import 'my_method_channel.dart';
import 'my_platform_interface.dart';


class MyPlatformPlugin {

  Future<String?> getPlatformVersion() {
    return MyPlatformInterface.instance.getPlatformVersion();
  }

  void setPushClickCallBack(PushClickCallBack callback) {
    MyPlatformInterface.instance.setPushClickCallBack(callback);
  }

  void init(){
    MyPlatformInterface.instance.configure();
  }

}
