import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/services.dart';
import 'package:flutter_fire_callback/my_platform_plugin.dart';
import 'package:flutter_fire_callback/my_platform_interface.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// On Commenting the below listener, _onPushClick method channel callbacks are working fine
  /// When the below listener is added and push clicked method channel method is called from native android, the callback is not coming flutter method channel call handler
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  MyPlatformInterface.instance
    ..configure()
    ..setPushClickCallBack(_onPushClick);

  runApp(const MyApp());

}

/// When onBackgroundMessage listener is added , the method channel callbacks in plugin are not working, so this _onPushClick is also not invoked.
void _onPushClick(Map<String,dynamic> message) {
  print("Main : _onPushClick(): This is a push click callback from native to flutter. Payload $message");
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterFireCallbackPlugin = MyPlatformPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _flutterFireCallbackPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
