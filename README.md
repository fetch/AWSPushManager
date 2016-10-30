# AWSPushManager

AWS SNS Push registration manager

The code of this library was extracted from the mobile hub example application.

It works with both Objective-C and Swift.

## Dependencies

Direct dependencies are the `AWSCore` and `AWSSNS` frameworks.

To actually be able to communicate with AWS the `AWSCognito` framework is required as well.

## Installation

### Using CocoaPods

This is the easiest, because it also installs the required dependencies.

Add `AWSPushManager` to the `Podfile`.

```
pod 'AWSPushManager', '~> 1.0.0'
```

### Manual installation

Copy `AWSPushManager.h` and `AWSPushManager.m` to your project, and make sure to add the `AWSCore` and `AWSSNS` frameworks.

## Initialization

**Objective-C**

Import the headers:

```objc
#import <AWSPushManager/AWSPushManager.h>
```

And update `AppDelegate.m` to match with the following:

```objc
- (BOOL)didFinishLaunching:(UIApplication *)application
              withOptions:(NSDictionary *)launchOptions {

    NSString *platformARN = @"arn:aws:sns:us-east-1:123456789:app/APNS_SANDBOX/SomeAppName";
    [AWSPushManager defaultPushManager].defaultPlatformARN = platformARN;

    return [[AWSPushManager defaultPushManager] interceptApplication:application
                                       didFinishLaunchingWithOptions:launchOptions];
}

- (void)application:(UIApplication *)application
                          didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[AWSPushManager defaultPushManager] interceptApplication:application
             didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
                          didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[AWSPushManager defaultPushManager] interceptApplication:application
             didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application
                          didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[AWSPushManager defaultPushManager] interceptApplication:application
                                 didReceiveRemoteNotification:userInfo];
}
```

-----

**Swift**

Import the framework:

```swift
import AWSPushManager
```

Or if not using frameworks import the headers in your `App-Bridging-Header.h`.

```objc
#import <AWSPushManager/AWSPushManager.h>
```

And update `AppDelegate.swift` to match with the following:

```swift
func application(application: UIApplication,
                didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    let platformARN = "arn:aws:sns:us-east-1:123456789:app/APNS_SANDBOX/SomeAppName"
    AWSPushManager.setDefaultPlatformARN(platformARN)

    return AWSPushManager.defaultPushManager().interceptApplication(application,
                didFinishLaunchingWithOptions: launchOptions)
}

func application(application: UIApplication,
                didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    AWSPushManager.defaultPushManager().interceptApplication(application,
                didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
}

func application(application: UIApplication,
                didFailToRegisterForRemoteNotificationsWithError error: NSError) {
    AWSPushManager.defaultPushManager().interceptApplication(application,
                didFailToRegisterForRemoteNotificationsWithError: error)
}

func application(application: UIApplication,
                didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    AWSPushManager.defaultPushManager().interceptApplication(application,
                didReceiveRemoteNotification: userInfo)
}

```

## Usage

### Minimal configuration

To start receiving notifications, you have to subscribe to one or more topics.

**Objective-C**

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    AWSPushManager *pushManager = [AWSPushManager defaultPushManager];
    [pushManager registerForPushNotifications];
    NSString *topicARN = @"arn:aws:sns:us-east-1:123456789:SomeApp_alldevices";
    [pushManager registerTopicARNs:@[topicARN, ]];
}
```

----

**Swift**

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    let pushManager = AWSPushManager.defaultPushManager()
    pushManager.registerForPushNotifications()
    let topicARN = "arn:aws:sns:us-east-1:123456789:SomeApp_alldevices"
    pushManager.registerTopicARNs([topicARN])
}
```


To respond to notifications anywhere in your application, you can use `AWSPushManager`'s delegate:

**Objective-C**

```objc
- (void)pushManager:(AWSPushManager *)pushManager
        didReceivePushNotification:(NSDictionary *)userInfo;
```

**Swift**

```swift
func pushManager(pushManager: AWSPushManager!,
        didReceivePushNotification userInfo: [NSObject : AnyObject]!)
```

### Documentation

Full library documentation can be found on CocoaDocs: http://cocoadocs.org/docsets/AWSPushManager/

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

