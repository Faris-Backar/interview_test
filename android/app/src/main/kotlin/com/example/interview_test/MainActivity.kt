package com.example.interview_test

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint
import io.flutter.plugin.common.MethodChannel
import android.bluetooth.BluetoothAdapter


class MainActivity: FlutterActivity() {
    private val CHANNEL = "bluetooth_channel"

private lateinit var methodChannel: MethodChannel
private lateinit var bluetoothAdapter: BluetoothAdapter

override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
    methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
    methodChannel.setMethodCallHandler { call, result ->
        when (call.method) {
            "getBluetoothStatus" -> {
                getBluetoothStatus(result)
            }
            "enableBluetooth" -> {
                enableBluetooth(result)
            }
            "disableBluetooth" -> {
                disableBluetooth(result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}
private fun getBluetoothStatus(result: MethodChannel.Result) {
    val isEnabled = bluetoothAdapter.isEnabled
    result.success(isEnabled)
}
private fun enableBluetooth(result: MethodChannel.Result) {
    bluetoothAdapter.enable()
    result.success(true)
}
private fun disableBluetooth(result: MethodChannel.Result) {
    bluetoothAdapter.disable()
    result.success(true)
}


}
