package com.example.flutter.callback.flutter_fire_callback_example

import android.content.Intent
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import com.example.flutter.callback.flutter_fire_callback.PlatformHelper
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity


class MainActivity : FlutterActivity() {

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        val remoteMessage = intent.getStringExtra("remoteMessage")
        Handler(Looper.getMainLooper()).post {
            if (remoteMessage != null) {
                PlatformHelper.platformChannel?.invokeMethod(
                    "onPushClick",
                    remoteMessage
                )
            }
        }
        Toast.makeText(this, "On New Intent MainActvity", Toast.LENGTH_SHORT).show()
    }
}
