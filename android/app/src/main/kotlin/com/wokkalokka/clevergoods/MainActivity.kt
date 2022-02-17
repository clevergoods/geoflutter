package com.wokkalokka.clevergoods

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.*
import io.flutter.embedding.android.FlutterActivity
import android.util.Log;
import com.wokkalokka.clevergoods.models.ObjectBox
import com.wokkalokka.clevergoods.models.ObjectboxAUserModel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StringCodec
import java.time.LocalDateTime

class MainActivity: FlutterActivity() {

    private val METHOD_CHANNEL = "samples.flutter.dev/method"
    private val MESSAGE_CHANNEL = "samples.flutter.dev/message"
    private val logTag = "MainActivity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Thread.setDefaultUncaughtExceptionHandler({ thread, exception ->
            Log.e(logTag, exception.stackTrace.toString())
        })
        ObjectBox.init(this)
        Log.d(logTag, "OPEN ObjectBox from Android")
        val userBox = ObjectBox.store.boxFor(ObjectboxAUserModel::class.java)

        val users = userBox.all
        if(users.isNotEmpty()){
            val user = users.get(0)
            Log.d(logTag, "User login from ObjectBox: ${user.login}")
        }
    }

    override fun onResume() {
        super.onResume()
//        val userBox = ObjectBox.store.boxFor(ObjectboxAUserModel::class.java)
//
//        val user0 = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            ObjectboxAUserModel("login ${LocalDateTime.now()}.", "password")
//        } else {
//            //TODO("VERSION.SDK_INT < O")
//        }
//        userBox.put(user0)
//        Log.d(logTag, "allEntityClasses.size from ObjectBox: ${ObjectBox.store.allEntityClasses.size}")
//        val users = userBox.all
//        if(users.isNotEmpty()){
//            for(user in users) {
//                Log.d(logTag, "User login from ObjectBox: ${user.login} ${users.size}")
//            }
//        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messageChannel = BasicMessageChannel(flutterEngine.dartExecutor.binaryMessenger, MESSAGE_CHANNEL, StringCodec.INSTANCE)

        val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)

        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    //Ответить во flutter
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available.", null)
                    }

                    //Отправить сообщение flutter'у
                    messageChannel.send("messsage from $logTag") { reply ->
                        //Ответ от flutter
                        Log.d(logTag, "Ответ от flutter на сообщение [messsage from $logTag]: $reply")
                    }

                    //Вызвать метод из flutter
                    methodChannel.invokeMethod("incrementCounter", listOf("a", "b"), object : MethodChannel.Result {
                        //flutter метод вернул результат
                        override fun success(result: Any?) {
                            Log.d(logTag, "flutter метод incrementCounter вернул результат result counter = $result")
                        }
                        override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                            Log.d(logTag, "flutter метод incrementCounter вернул ошибку $errorCode, $errorMessage, $errorDetails")
                        }
                        override fun notImplemented() {
                            Log.d(logTag, "notImplemented")
                        }
                    })
                }

                "log" -> {
                    val logLevel = call.argument<String>("logLevel")
                    val logTag = call.argument<String>("logTag")
                    val logMessage = call.argument<String>("logMessage")
                    when (logLevel) {
                        "i" -> logMessage?.let { Log.i(logTag, it) }
                        "d" -> logMessage?.let { Log.d(logTag, it) }
                        "w" -> logMessage?.let { Log.w(logTag, it) }
                        "e" -> logMessage?.let { Log.e(logTag, it) }
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        // Receive messages from Dart
        messageChannel.setMessageHandler { message, reply ->
            Log.d(logTag, "Сообщение от flutter'а Received message = $message")
            reply.reply("Ответ flutter'у Reply from Android")
        }

        // Send message to Dart
        Handler(Looper.getMainLooper()).postDelayed({
            messageChannel.send("Сообщение flutter'у Hello World from Android") { reply ->
                Log.d(logTag, "Ответ от flutter'а: $reply")
            }
        }, 500)
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
    }
}
