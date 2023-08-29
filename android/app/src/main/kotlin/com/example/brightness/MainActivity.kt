package com.example.brightness

import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.properties.Delegates

class MainActivity: FlutterActivity() {
    private  lateinit var layout : WindowManager.LayoutParams
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        layout = window.attributes
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "brightnessPlatform",
        ).setMethodCallHandler { call, result ->
            when(call.method) {
                "setBrightness" -> {
                    val data = call.argument<Double>("brightness")
                    layout.screenBrightness = data?.toFloat() ?: 0f
                    window.attributes = layout
                }
                "getBrightness" -> {
                    result.success(layout.screenBrightness)
                } else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
