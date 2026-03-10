package com.example.emi_locker_plugin

import android.app.Activity
import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.os.UserManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class EmiLockerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var dpm: DevicePolicyManager? = null
    private var adminComponent: ComponentName? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "emi_locker/device_control")
        channel.setMethodCallHandler(this)
        val context = flutterPluginBinding.applicationContext
        dpm = context.getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager
        adminComponent = ComponentName(context, MyDeviceAdminReceiver::class.java)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "lockDevice" -> {
                lockDevice()
                result.success("Device Locked")
            }
            "unlockDevice" -> {
                unlockDevice()
                result.success("Device Unlocked")
            }
            else -> result.notImplemented()
        }
    }

    private fun lockDevice() {
        val currentActivity = activity ?: return
        val currentDpm = dpm ?: return
        val currentAdmin = adminComponent ?: return

        if (currentDpm.isDeviceOwnerApp(currentActivity.packageName)) {
            currentDpm.setLockTaskPackages(currentAdmin, arrayOf(currentActivity.packageName))
            currentDpm.setStatusBarDisabled(currentAdmin, true)
            currentDpm.setApplicationHidden(currentAdmin, "com.android.settings", true)

            currentDpm.addUserRestriction(currentAdmin, UserManager.DISALLOW_SAFE_BOOT)
            currentDpm.addUserRestriction(currentAdmin, UserManager.DISALLOW_INSTALL_APPS)
            currentDpm.addUserRestriction(currentAdmin, UserManager.DISALLOW_UNINSTALL_APPS)
            currentDpm.addUserRestriction(currentAdmin, UserManager.DISALLOW_FACTORY_RESET)

            currentActivity.startLockTask()
        }
    }

    private fun unlockDevice() {
        val currentActivity = activity ?: return
        val currentDpm = dpm ?: return
        val currentAdmin = adminComponent ?: return

        if (currentDpm.isDeviceOwnerApp(currentActivity.packageName)) {
            currentActivity.stopLockTask()
            currentDpm.setStatusBarDisabled(currentAdmin, false)
            currentDpm.setApplicationHidden(currentAdmin, "com.android.settings", false)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
