package com.example.flutter.callback.flutter_fire_callback

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterFireCallbackPlugin */
class FlutterFireCallbackPlugin: FlutterPlugin, MethodCallHandler {
  private var channel : MethodChannel?=null

  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_fire_callback")
    context  = flutterPluginBinding.applicationContext
    channel?.setMethodCallHandler(this)
    initMethodChannel(flutterPluginBinding)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel?.setMethodCallHandler(null)
  }

  private fun initMethodChannel(plugin: FlutterPlugin.FlutterPluginBinding) {
    val methodChannel = MethodChannel(plugin.binaryMessenger, METHOD_CHANNEL)
    PlatformHelper.setMethodChannel(methodChannel)
  }


  companion object {
    const val METHOD_CHANNEL = "com.example.flutter.callback.flutter_fire_callback/push"
  }

}
