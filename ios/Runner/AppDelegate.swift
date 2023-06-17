import UIKit
import Flutter
import <Flutter/Flutter.h
import <CoreBluetooth/CoreBluetooth.h>

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

static NSString *const kBluetoothChannel = @"bluetooth_channel";
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"enableBluetooth"]) {
        CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:nil queue:nil];
        [centralManager enable];
        result(@(YES));
    } else if ([call.method isEqualToString:@"disableBluetooth"]) {
        CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:nil queue:nil];
        [centralManager disable];
        result(@(YES));
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel* channel = [FlutterMethodChannel
        methodChannelWithName:kBluetoothChannel
              binaryMessenger:controller.binaryMessenger];
    [channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        [self handleMethodCall:call result:result];
    }];
}

}
