package com.stepanzalis.light_sensor

import android.content.Context
import android.hardware.*
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import android.hardware.SensorManager
import android.util.Log
import io.flutter.plugin.common.EventChannel
import java.util.logging.StreamHandler
import android.hardware.SensorEventListener
import android.hardware.SensorEvent
import android.os.Build
import android.annotation.TargetApi


class MainActivity : FlutterActivity() {

    private lateinit var sensorManager: SensorManager
    private var lightSensor: Sensor? = null
    private var sensorEventListener: SensorEventListener? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        lightSensor = sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT)

        GeneratedPluginRegistrant.registerWith(this)

        EventChannel(flutterView, PLATFORM_CHANNEL).setStreamHandler(object : StreamHandler(), EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                createLightSensorListener(events)
                subscribeToSensor()
            }

            override fun onCancel(arguments: Any?) {
                unsubscribeFromSensor()
            }
        })
    }

    fun createLightSensorListener(events: EventChannel.EventSink) {
        sensorEventListener = object : SensorEventListener {
            override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

            override fun onSensorChanged(event: SensorEvent) {
                val luxValue = event.values?.get(0)?.toDouble()
                events.success(luxValue)
            }
        }
    }

    private fun subscribeToSensor() {
        sensorManager.registerListener(sensorEventListener, lightSensor, SensorManager.SENSOR_DELAY_FASTEST)
    }

    private fun unsubscribeFromSensor() {
        sensorManager.unregisterListener(sensorEventListener)
    }
    
    companion object {
        private const val PLATFORM_CHANNEL = "com.stepanzalis.lightsensor/platform"
    }
}
