package com.example.call_detect

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterCallbackInformation

private  lateinit var  res : MethodChannel.Result
class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.call_detect";
    private  val TAG = "MainActivity"
    private lateinit var channel: MethodChannel
   /* override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->


        }

    }*/

    override fun onDestroy() {
        super.onDestroy()
    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d(TAG, "onCreate: ")
        registerReceiver(receiver, filter);
    }


    var filter = IntentFilter("com.example.call_detect")
    var receiver: BroadcastReceiver = object : BroadcastReceiver() {
        private  val TAG = "MainActivity"
        override fun onReceive(context: Context, intent: Intent) {
            val value = intent.extras!!.getString("value")
            Log.d(TAG, "onReceive: "+value)


            channel = MethodChannel(
                    flutterEngine!!.dartExecutor.binaryMessenger,
                    "com.example.call_detectback")
            channel.invokeMethod("onIncomingCallAnswered", value)




        }
    }

}
