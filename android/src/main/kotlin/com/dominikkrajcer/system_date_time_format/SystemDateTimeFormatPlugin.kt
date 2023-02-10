package com.dominikkrajcer.system_date_time_format

import android.content.Context
import android.text.format.DateFormat
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.text.SimpleDateFormat

/** SystemDateTimeFormatPlugin */
class SystemDateTimeFormatPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "system_date_time_format")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getDateFormat" -> result.success(getDateFormat())
            "getMediumDateFormat" -> result.success(getMediumDateFormat())
            "getLongDateFormat" -> result.success(getLongDateFormat())
            "getTimeFormat" -> result.success(getTimeFormat())
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    private fun getDateFormat(): String {
        val dateFormat = DateFormat.getDateFormat(applicationContext)
        return (dateFormat as SimpleDateFormat).toLocalizedPattern()
    }

    private fun getMediumDateFormat(): String {
        val mediumDateFormat = DateFormat.getMediumDateFormat(applicationContext)
        return (mediumDateFormat as SimpleDateFormat).toLocalizedPattern()
    }

    private fun getLongDateFormat(): String {
        val longDateFormat = DateFormat.getLongDateFormat(applicationContext)
        return (longDateFormat as SimpleDateFormat).toLocalizedPattern()
    }

    private fun getTimeFormat(): String {
        val timeFormat = DateFormat.getTimeFormat(applicationContext)
        return (timeFormat as SimpleDateFormat).toLocalizedPattern()
    }
}
