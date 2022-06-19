import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCTvM66hS9Mae3VH5IAYAAWoEml1UXdj30")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)

  }
}



//EGENIN KEY

//GeneratedPluginRegistrant.register(with: self)
//GMSServices.provideAPIKey("AIzaSyD7GbaT3_pCgN-1FK6WRWwXE1K9mW-aMXA")
//return super.application(application, didFinishLaunchingWithOptions: launchOptions)



