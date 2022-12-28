package com.example.flutter.callback.flutter_fire_callback_example

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.util.Log
import com.google.firebase.messaging.FirebaseMessaging
import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MyApp : FlutterApplication() {

    private val TAG = this.javaClass.simpleName

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "MyApp Launched")
        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
        createNotificationChannel()
        FirebaseMessaging.getInstance().token.addOnSuccessListener {
            Log.d(TAG, "Token:$it")
        }
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val channelName = "General"
        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val channel = NotificationChannel(FCMService.NOTIFICATION_CHANNEL_1, channelName, NotificationManager.IMPORTANCE_DEFAULT)
        manager.createNotificationChannel(channel)
    }

}