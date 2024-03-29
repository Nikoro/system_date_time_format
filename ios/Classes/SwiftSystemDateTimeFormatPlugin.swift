import Flutter
import UIKit

public class SwiftSystemDateTimeFormatPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "system_date_time_format", binaryMessenger: registrar.messenger())
    let instance = SwiftSystemDateTimeFormatPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
      case "getDateFormat":
          result(getDateFormat())
      case "getMediumDateFormat":
          result(getMediumDateFormat())
      case "getLongDateFormat":
          result(getLongDateFormat())
      case "getFullDateFormat":
          result(getFullDateFormat())
      case "getTimeFormat":
          result(getTimeFormat())
      default:
          result(FlutterMethodNotImplemented)
      }
  }
    
    private func getDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.dateFormat
    }
    
    private func getMediumDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.dateFormat
    }
    
    private func getLongDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.dateFormat
    }
    
    private func getFullDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.dateFormat
    }
    
    private func getTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.dateFormat
    }
}
