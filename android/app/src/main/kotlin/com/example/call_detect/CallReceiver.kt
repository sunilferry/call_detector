package com.example.call_detect

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager
import android.util.Log


/**
 *Developed by Suneel kumar 10-03-2022
 */
var isIncoming: Boolean = false
class CallReceiver: BroadcastReceiver() {
    private  val TAG = "CallReceiver"


    override fun onReceive(context: Context, intent:Intent) {
        val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
        Log.d(TAG, "onReceive: "+state)
        val intent1 = Intent("com.example.call_detect")
        state?.let { state ->

            if(state == TelephonyManager.EXTRA_STATE_RINGING) {
                isIncoming=true

                intent1.putExtra("value", "INCOMING")
                context.sendBroadcast(intent1)
            }

            if(!isIncoming){
                if(state == TelephonyManager.EXTRA_STATE_OFFHOOK) {
                    intent1.putExtra("value", "OUTGOING")
                    context.sendBroadcast(intent1)
                }
            }

            if(state.equals(TelephonyManager.EXTRA_STATE_IDLE)) {
                isIncoming=false
                intent1.putExtra("value", "END")
                context.sendBroadcast(intent1)

            }


        }
    }
}