package com.example.flutter.callback.flutter_fire_callback

import io.flutter.plugin.common.MethodChannel

object PlatformHelper {
    var platformChannel: MethodChannel? = null

    fun setMethodChannel(methodChannel: MethodChannel) {
        platformChannel = methodChannel
    }

}