import UIKit
import Flutter
import os.log

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let methodChannelName = "samples.flutter.dev/method"
    let messageChannelName = "samples.flutter.dev/message"
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let registrar = self.registrar(forPlugin: "Echo")!
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let messageChannel = FlutterBasicMessageChannel(
              name: messageChannelName, binaryMessenger: registrar.messenger(),
              codec: FlutterStringCodec.sharedInstance())
        
        messageChannel.setMessageHandler { (input, reply) in
            os_log("messageChannel received result: %@", input as! CVarArg)
            reply(input)
        }
        
        let methodChannel = FlutterMethodChannel(name:methodChannelName, binaryMessenger: controller.binaryMessenger)
        
        methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result:@escaping FlutterResult) -> Void in
            switch call.method {
            case "getBatteryLevel":
                do {
//                    if let args = call.arguments as? Dictionary<String, Any>,
//                        let number = args["number"] as? Int,
//                        let times = args["times"] as? Int {
//                        self.receiveBatteryLevel(result: result)
//                    }
                    self.receiveBatteryLevel(result: result)
                    
                    var args = [String: Any]()
                    args["itemId"] = "itemId"
                    args["quantity"] = "quantity"
                    methodChannel.invokeMethod("incrementCounter", arguments: args, result: {(r:Any?) -> () in
                        os_log("invokeMethod(incrementCounter) result: %@", r as! CVarArg)
                    })
                    
                    // Send message to Dart and receive reply.
                    messageChannel.sendMessage("Send message to flutter Hello, world") {(reply: Any?) -> Void in
                      os_log("AppDelegate: %@", type: .info, reply as! String)
                    }
                   break
                }
            case "log":
                do {
                    if let args = call.arguments as? Dictionary<String, Any>,
                        let logLevel = args["logLevel"] as? String,
                        let logTag = args["logTag"] as? String,
                        let logMessage = args["logMessage"] as? CVarArg{
                        switch logLevel {
                        case "i":
                            os_log("%{public}@: %{public}@", log: OSLog.default, type: .info, logTag, logMessage)
                            break
                        case "d":
                            os_log("%{public}@: %{public}@", log: OSLog.default, type: .debug, logTag, logMessage)
                            break
                        case "w":
                            os_log("%{public}@: %{public}@", log: OSLog.default, type: .error, logTag, logMessage)
                            break
                        case "e":
                            os_log("%{public}@: %{public}@", log: OSLog.default, type: .fault, logTag, logMessage)
                            break
                        default:
                            result(FlutterMethodNotImplemented)
                            break
                        }                      
                      } else {
                        result(FlutterError.init(code: "bad args", message: nil, details: nil))
                      }
                    break
                }
            default:
                do {
                    result(FlutterMethodNotImplemented)
                    break
                }
            }
        })
        
       
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func receiveBatteryLevel(result: FlutterResult){
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if(device.batteryState == UIDevice.BatteryState.unknown){
            result(FlutterError(code: "UNAVAILABLE",
                                message : "Battery info unavailable",
                                details: nil))
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
}
