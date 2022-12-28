package com.example.flutter.callback.flutter_fire_callback_example

import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.media.RingtoneManager
import android.net.Uri
import android.util.Log
import androidx.core.app.NotificationCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.google.gson.Gson

class FCMService : FirebaseMessagingService() {

    private val TAG = this.javaClass.simpleName

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)
        Log.d(TAG,message.notification?.title.toString())
        sendNotification(remoteMessage = message)
    }

    override fun onNewToken(token: String) {
        super.onNewToken(token)
        Log.d(TAG, token)
    }


    companion object {
        const val NOTIFICATION_CHANNEL_1 = "general_notification_channel"
    }

    private fun sendNotification(remoteMessage: RemoteMessage) {
        Log.d(TAG, "Message:$remoteMessage")
        val notification = remoteMessage.notification
        val requestID = System.currentTimeMillis().toInt()
        val intent = Intent(this,MainActivity::class.java)
        intent.putExtra("remoteMessage",Gson().toJson(remoteMessage))
        intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
        val pendingIntent = PendingIntent.getActivity(this, requestID, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val defaultSoundUri: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
        val notificationBuilder: NotificationCompat.Builder =
            NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_1)
                .setLargeIcon(
                    BitmapFactory.decodeResource(
                        resources,
                        android.R.drawable.ic_lock_idle_alarm
                    )
                )
                .setSmallIcon(android.R.drawable.ic_lock_lock)
                .setContentTitle(notification?.title ?: "DEFAULT BODY")
                .setContentText(notification?.body ?: "DEFAULT TITLE")
                .setAutoCancel(true)
                .setSound(defaultSoundUri)
                .setContentIntent(pendingIntent)
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as? NotificationManager
        notificationManager?.notify(0, notificationBuilder.build())
    }

}