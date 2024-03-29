# Blesh iOS SDK 5 Developer Guide

**Version:** *5.5.0*

This document describes integration of the Blesh iOS SDK with your iOS application.

## Introduction

Blesh iOS SDK collects location information from a device on which the iOS application is installed. Blesh Ads Platform uses this data for creating and enhancing audiences, serving targeted ads, and insights generation.

## Table of Contents

- [Blesh iOS SDK 5 Developer Guide](#blesh-ios-sdk-5-developer-guide)
  - [Introduction](#introduction)
  - [Table of Contents](#table-of-contents)
  - [Changelog](#changelog)
  - [Requirements](#requirements)
  - [Integration](#integration)
    - [1. Adding the Blesh iOS SDK](#1-adding-the-blesh-ios-sdk)
      - [1.1. Adding the Blesh iOS SDK with Swift Package Manager](#11-adding-the-blesh-ios-sdk-with-swift-package-manager)
      - [1.2. Adding the Blesh iOS SDK with CocoaPods](#12-adding-the-blesh-ios-sdk-with-cocoapods)
      - [1.3. Adding the Blesh iOS SDK Manually](#13-adding-the-blesh-ios-sdk-manually)
    - [2. Notifying the Blesh iOS SDK About Push Notifications](#2-notifying-the-blesh-ios-sdk-about-push-notifications)
      - [2.1. APNs](#21-apns)
        - [2.1.1. Example](#211-example)
      - [2.2. FCM](#22-fcm)
        - [2.2.1. Example](#221-example)
    - [3. Adding Frameworks](#3-adding-frameworks)
    - [4. Adding Supporting Files](#4-adding-supporting-files)
    - [5. Reviewing Permissions](#5-reviewing-permissions)
  - [Usage](#usage)
    - [1. Entering the Blesh Ads Platform Access Key](#1-entering-the-blesh-ads-platform-access-key)
    - [2. Starting the Blesh iOS SDK](#2-starting-the-blesh-ios-sdk)
        - [Example: Simple Initialization (Singleton)](#example-simple-initialization-singleton)
        - [Example: Simple Initialization](#example-simple-initialization)
        - [Example: Complete Initialization](#example-complete-initialization)
    - [3. Notifying the Blesh iOS SDK About Changes in Permissions](#3-notifying-the-blesh-ios-sdk-about-changes-in-permissions)
    - [4. Implementing the Blesh iOS SDK Delegate](#4-implementing-the-blesh-ios-sdk-delegate)
    - [5. Supporting Images with Remote Push Notifications](#5-supporting-images-with-remote-push-notifications)

## Changelog

  * **5.5.0** *(Released 2023-10-06)*
    * Supported text components in interstitials
    * Improved interstitial layout
    * Supported intersitial background layer interactions
    * Added an ability to load remote ads
    * Improved APNs support

  * **5.4.10** *(Released 2023-07-20)*
    * Added helper methods to identify Blesh notifications

  * **5.4.9** *(Released 2023-07-14)*
    * Improved APNs support
    * Set minimum iOS version to 11

  * **5.4.8** *(Released 2023-04-15)*
    * Improved compatibility with Xcode 13+

  * **5.4.7** *(Released 2023-01-12)*
    * Added React Native compatibility for bundle versions

  * **5.4.6** *(Released 2022-12-20)*
    * Added iOS 15+ compatibility for location requests

  * **5.4.5** *(Released 2022-11-11)*
    * Improved beacon scanning

  * **5.4.4** *(Released 2022-11-10)*
    * Improved remote push notification message handling

  * **5.4.3** *(Released 2022-11-08)*
    * Added support for text PN tokens

  * **5.4.2** *(Released 2022-08-26)*
    * Added initializers for backwards compatibility

  * **5.4.1** *(Released 2022-08-15)*
    * Updated the Swift compiler to 5.6
    * Made start(withSecretKey ...) method public again

  * **5.4.0** *(Released 2022-07-03)*
    * Added beacon scanning
    * Added remote push notifications
    * Added motion activity transitions

  * **5.3.0** *(Released 2022-04-12)*
    * Added in-app behavior tracking

  * **5.2.10** *(Released 2022-03-22)*
    * Added arm64 support for simulator

  * **5.2.9** *(Released 2021-11-22)*
    * Updated the Swift compiler to 5.5

  * **5.2.8** *(Released 2021-09-22)*
    * Updated the Swift compiler to 5.4

  * **5.2.7** *(Released 2021-05-04)*
    * Released as xcframework

  * **5.2.6** *(Released 2020-10-05)*
    * Updated the Swift compiler to 5.3

  * **5.2.5** *(Released 2020-07-27)*
    * Updated the Swift compiler to 5.1

  * **5.2.4** *(Released 2020-07-27)*
    * Enhanced rendering

  * **5.2.3** *(Released 2020-05-20)*
    * Added archived version of the SDK

  * **5.2.2** *(Released 2020-05-18)*
    * Enabled bitcode for all architectures

  * **5.2.1** *(Released 2020-05-08)*
    * Added support for custom background layers

  * **5.2.0** *(Released 2020-05-02)*
    * Updated the Swift compiler to 5.2

  * **5.1.5** *(Released 2020-04-18)*
    * Enabled bitcode

  * **5.1.4** *(Released 2020-01-20)*
    * Changed the Swift compiler to 5

  * **5.1.3** *(Released 2020-01-07)*
    * Improved iOS 13 compatibility

  * **5.1.2** *(Released 2020-01-07)*
    * Improved iOS 13 compatibility

  * **5.1.1** *(Released 2020-01-06)*
    * Added English and Turkish localizations

  * **5.1.0** *(Released 2019-12-27)*
    * Added local push notification support
    * Added more location handlers

  * **5.0.1** *(Released 2019-11-28)*
    * Removed Core Bluetooth framework

  * **5.0.0** *(Released 2019-11-26)*
    * Added initialization support
    * Added callback handler for handling changes in the location permission
    * Supported server-side HTTP compression
    * Compiled as a Mac-O Universal binary

<div style="page-break-after: always;"></div>

## Requirements

In order to integrate the Blesh iOS SDK make sure you are:

  * Targeting iOS version 11 or higher
  * Targeting the Swift 5 compiler
  * Enabling the "`Always Embed Swift Standard Libraries`" build option (or the "`Embedded Content Contains Swift Code`" build option for older versions of Xcode) if your application is developed using the Objective-C language
    * Swift Standard Libraries are required for iOS versions 12.1 or earlier. See [QA1881](https://developer.apple.com/library/archive/qa/qa1881/_index.html) for details
  * Registered on the *Blesh Publisher Portal*
    * You may need to create a *Blesh Ads Platform Access Key* for the iOS platform

> **Note:** Make sure that you declare that "your app uses IDFA" on App Store Connect. Otherwise, your app may be rejected on review. Blesh iOS SDK collects IDFA from the device, in full compliance with the Apple [requirements](https://support.apple.com/en-us/HT205223).

## Integration

### 1. Adding the Blesh iOS SDK

The Blesh iOS SDK can be added by using various dependency managers or manually.

#### 1.1. Adding the Blesh iOS SDK with Swift Package Manager

Newer Xcode versions support adding packages through the IDE interface. Blesh iOS SDK can be easily integrated by following steps below.

**Steps to add:**

1. Select "`Add Packages`" in the "`File`" menu.
2. Enter the GitHub address [https://github.com/bleshcom/Blesh-iOS-SDK](https://github.com/bleshcom/Blesh-iOS-SDK) for the input labeled "`Search or Enter Package URL`".
3. Xcode will automatically fetch package details. Select "`Up to Next Major Version`" for the "`Dependency Rule`" input. This will allow you to easily keep Blesh iOS SDK up-to-date.
4. Select your application project for the "`Add to Project`" input.
5. Click on the "`Add Package`" button and select your application project in the "`Add to Target`" column.
6. Click on the "`Add Package`" button.

#### 1.2. Adding the Blesh iOS SDK with CocoaPods

Referencing the `BleshSDK` pod in the `Podfile` will be sufficient to add the Blesh iOS SDK to your project.

**Steps to add:**

1. If your project doesn't have a `Podfile` then you can create one by running the following command on the terminal:

```bash
pod init
```

2. Reference `BleshSDK` in the `Podfile`:

```podspec
target 'YOUR_APPLICATION_NAME' do

  # ... beginning of your Podfile ...

  pod 'BleshSDK' # this will reference the Blesh iOS SDK 5

  # ... remaining of your Podfile ...

end
```

> **Note:** Replace `YOUR_APPLICATION_NAME` with the name of your application in the `target` section

<div style="page-break-after: always;"></div>

3. Install pods by running the following command on the terminal:

```bash
pod install
```

#### 1.3. Adding the Blesh iOS SDK Manually

1. Download the SDK

You can download the SDK from the following repository:

```
https://github.com/bleshcom/Blesh-iOS-SDK.git
```

To integrate a specific version of the SDK, a git revision with the tag for the desired version should be checked out.

2. Add `BleshSDK.framework` to your Xcode project

### 2. Notifying the Blesh iOS SDK About Push Notifications

Blesh iOS SDK **must be** notified when a push notification is about to be displayed and when a user interacted with a push notification. This will allow Blesh iOS SDK to:

- Display a notification when the application is in the foreground (iOS 10+)
- Display an ad when the user taps a notification

Blesh iOS SDK supports remote push notifications throught Apple Push Notification service ([APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns)) and Firebase Cloud Messaging ([FCM](https://firebase.google.com/docs/cloud-messaging)).

> **Note:** APNs & Firebase certificates need to be registered on the [Blesh Publisher Portal](https://publisher.blesh.com).

#### 2.1. APNs

Below examples assume that you have integrated Apple Push Notification service with your application.
Please refer to the [APNs iOS Documentation](https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns) for more information.

##### 2.1.1. Example

**Swift:**

```swift
import UIKit
import UserNotifications
import BleshSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // mark this class as a UNUserNotificationCenterDelegate
        UNUserNotificationCenter.current().delegate = self

        // enable remote notifications
        application.registerForRemoteNotifications()

        // ... rest of the method ...

        return true
    }

    // support remote notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // notify Blesh SDK
        BleshSdk.sharedInstance.didReceiveRemoteNotification(userInfo) { UIBackgroundFetchResult in
            completionHandler(.newData)
        }

        // ... rest of the method ...
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("Failed to register for remote notifications: \(error)")
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // notify Blesh SDK
        BleshSdk.sharedInstance.didReceiveDeviceToken(deviceToken)

        // ... rest of the method ...
    }

    // this method will be called when app received push notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // deliver to Blesh SDK
        BleshSdk.sharedInstance.didReceiveUNNotificationResponse(response)

        completionHandler()
    }

    // ... rest of the class ...
}
```

**Example:** Objective-C (AppDelegate.h)

```objective-c
#import <UserNotifications/UserNotifications.h>

// ... rest of imports ...

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

// ... rest of the interface ...

@end
```

**Example:** Objective-C (AppDelegate.m)

```objective-c
#import <BleshSDK/BleshSDK.h>
// ... rest of imports ...

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // mark this class as a UNUserNotificationCenterDelegate
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];

    // enable remote notifications
    [[UIApplication sharedApplication] registerForRemoteNotifications];

    // ... rest of the method ...

    return YES;
}

// support remote notifications
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // notify Blesh SDK
    [[BleshSdk sharedInstance] didReceiveRemoteNotification:userInfo completion:^(UIBackgroundFetchResult result) {
        completionHandler(UIBackgroundFetchResultNewData);
    }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // notify Blesh SDK
    [[BleshSdk sharedInstance] didReceiveDeviceToken:deviceToken];
}

// this method will be called when app received push notifications in foreground
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
  completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
  // deliver to Blesh SDK
  [[BleshSdk sharedInstance] didReceiveUNNotificationResponse:response];

  completionHandler();
}

// ... rest of the class ...

@end
```

#### 2.2. FCM

Below examples assume that you have integrated Firebase Messaging with your application.
Please refer to the [FCM iOS Documentation](https://firebase.google.com/docs/cloud-messaging/ios/client#fetching-the-current-registration-token) for more information.

##### 2.2.1. Example

**Swift:**

```swift
import UIKit
import UserNotifications
import BleshSDK
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // mark this class as a UNUserNotificationCenterDelegate
        UNUserNotificationCenter.current().delegate = self

        // enable remote notifications
        application.registerForRemoteNotifications()

        // ... rest of the method ...

        return true
    }

    // support remote notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // notify FCM
        Messaging.messaging().appDidReceiveMessage(userInfo)

        // notify Blesh SDK
        BleshSdk.sharedInstance.didReceiveRemoteNotification(userInfo) { UIBackgroundFetchResult in
            completionHandler(.newData)
        }

        // ... rest of the method ...
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // notify FCM
        Messaging.messaging().apnsToken = deviceToken

        // notify Blesh SDK
        BleshSdk.sharedInstance.didReceiveDeviceToken(deviceToken)

        // ... rest of the method ...
    }

    // this method will be called when app received push notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // deliver to FCM
        Messaging.messaging().appDidReceiveMessage(notification.request.content.userInfo)

        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // deliver to FCM
        Messaging.messaging().appDidReceiveMessage(response.notification.request.content.userInfo)

        // deliver to Blesh SDK
        BleshSdk.sharedInstance.didReceiveUNNotificationResponse(response)

        completionHandler()
    }

    // ... rest of the class ...
}
```

**Example:** Objective-C (AppDelegate.h)

```objective-c
#import <UserNotifications/UserNotifications.h>
#import <FirebaseMessaging/FirebaseMessaging.h>

// ... rest of imports ...

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate, FIRMessagingDelegate>

// ... rest of the interface ...

@end
```

**Example:** Objective-C (AppDelegate.m)

```objective-c
#import <BleshSDK/BleshSDK.h>
// ... rest of imports ...

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // mark this class as a UNUserNotificationCenterDelegate
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];

    // enable remote notifications
    [[UIApplication sharedApplication] registerForRemoteNotifications];

    // ... rest of the method ...

    return YES;
}

// support remote notifications
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // notify FCM
    [[FIRMessaging messaging] appDidReceiveMessage:userInfo];

    // notify Blesh SDK
    [[BleshSdk sharedInstance] didReceiveRemoteNotification:userInfo completion:^(UIBackgroundFetchResult result) {
        completionHandler(UIBackgroundFetchResultNewData);
    }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // notify FCM
    [[FIRMessaging messaging] setAPNSToken:deviceToken];

    // notify Blesh SDK
    [[BleshSdk sharedInstance] didReceiveDeviceToken:deviceToken];
}

// this method will be called when app received push notifications in foreground
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
  // deliver to FCM
  [[FIRMessaging messaging] appDidReceiveMessage:notification.request.content.userInfo];

  completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
  // deliver to FCM
  [[FIRMessaging messaging] appDidReceiveMessage:response.notification.request.content.userInfo];

  // deliver to Blesh SDK
  [[BleshSdk sharedInstance] didReceiveUNNotificationResponse:response];

  completionHandler();
}

// ... rest of the class ...

@end
```

### 3. Adding Frameworks

Blesh iOS SDK utilizes following frameworks. Please make sure that your project references all of them:

 * Foundation.framework
 * UIKit.framework
 * AdSupport.framework
 * CoreLocation.framework
 * CoreTelephony.framework
 * SystemConfiguration.framework

### 4. Adding Supporting Files

Blesh iOS SDK plays its default sound file `BleshNotification.caf` for supported ads. You can download the sound file from [this link](https://github.com/bleshcom/Blesh-iOS-SDK/blob/master/Supporting%20Files/BleshNotification.caf?raw=true) and copy into your application's `Supporting Files` folder. If this file doesn't exist then the SDK plays the default iOS notification sound.

### 5. Reviewing Permissions

In order to provide proper notifications and proper beacon tracking, you need to get some permission from the application user, after your application is installed. Per iOS User guides, applications can ask for required permissions with their own sentences. The permissions can be configured in `Info.plist` file.

Blesh iOS SDK uses iBeacon protocol which requires location permission by default. Blesh iOS SDK needs to detect beacons and geofences even when the app is at background or killed. Therefore you have to ask for *"Always usage of location"* to your users.

Until iOS 11, when the users give permission for location usage, it was considered as *"Always"* and applications could use the location when they are killed or at background.

After iOS 11, the rules have changed and users were able to give location usage permission only when the application is in use. As a result, for iOS v11 and later, applications have to ask for two different types of location permissions: `WhenInUse` or `AlwaysAndWhenInUse`.

For backward compatibility, your application should include all three descriptors given below for location permission:

 * NSLocationAlwaysAndWhenInUseUsageDescription
 * NSLocationWhenInUseUsageDescription
 * NSLocationAlwaysUsageDescription

In the description field of location permission entries, we recommend you to encourage your users to allow *"Always use my location"*, in order to have a better performance of the system. In the below subsections, we provide some sample description text. Please check and consider them.

Please note that, with iOS version 11, applications must include all of the below 3 descriptors in their `Info.plist` file for backward compatibility with older OS versions.

1. **Always And When In Use**

This descriptor is used for iOS 11 and later. Provides permission for both when in use and when killed.

Sample Text: *"This application uses your location in order to inform you about interesting offers nearby. We advice you to choose Always option to get the offers even when you are not using the application!"*

You can insert it into your `Info.plist` file in the following syntax.

```xml
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string><# insert always and when in use usage description text #></string>
```

2. **Always**

This descriptor is used for iOS 10 and before versions. Provides permission for both when in use and when killed.

Sample Text: *"This application uses your location in order to inform you about interesting offers nearby. We advice you to choose Always option to get the offers even when you are not using the application!"*

You can insert it into your `Info.plist` file in the following syntax.

```xml
<key>NSLocationAlwaysUsageDescription</key>
<string><# insert always usage description text #></string>
```

3. **When In Use**

This descriptor is used in all iOS versions. Provides permission for only when the application is in use. We advice you to warn your users about very low performance on receiving nearby offers.

Sample Text: *“This application uses your location in order to inform you about interesting offers nearby. Allowing location when in use only may result in poor performance in finding nearby offers!”*

You can insert it into your `Info.plist` file in the following syntax.

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string><# insert when in use usage description text #></string>
```

## Usage

In order to utilize capabilities of the Blesh iOS SDK, it needs to be started at some point of your application's lifecycle.

### 1. Entering the Blesh Ads Platform Access Key

Blesh iOS SDK requires the **Blesh Ads Platform Access Key**. You may need to create one for the iOS platform at the *Blesh Publisher Portal*. If you do not have an account at the *Blesh Publisher Portal* please contact us at technology@blesh.com. You can set your key in your application's `Info.plist` file with the `Blesh Platform Access Key` key:

```xml
<key>Blesh Platform Access Key</key>
<string>YOUR_SECRET_KEY_HERE</string>
```

Alternatively, you can provide the **Blesh Ads Platform Access Key** via the SDK `start` method as documented in the next section. 

### 2. Starting the Blesh iOS SDK

You can either create & manage a new instance of `BleshSdk` or you can access the `BleshSdk` singleton instance through `BleshSdk.sharedInstance`.

In order to continue to receive notifications even when the app is **killed/not running in the background**, invoking `start` method should not require the application to be in the foreground. Please note that best practice is starting Blesh under **applicationDidFinishLaunchingWithOptions** in the app delegate.

`BleshSdk` contains following `start` methods:

**Swift:**

```swift
start(
      withSecretKey: String?,
      withApplicationUser: BleshSdkApplicationUser?,
      withConfiguration: BleshSdkConfiguration?,
      completionHandler: ((BleshSdkStartState) -> Void)?)
```

**Objective-C:**

```objective-c
- (void)startWithApplicationUser:(BleshSdkApplicationUser *)applicationUser 
               withConfiguration:(BleshSdkConfiguration *)configuration 
               completionHandler:(void (^)(enum BleshSdkStartState))completionHandler;

- (void)startWithSecretKey:(NSString *)secretKey 
       withApplicationUser:(BleshSdkApplicationUser *)applicationUser 
         withConfiguration:(BleshSdkConfiguration *)configuration 
         completionHandler:(void (^)(enum BleshSdkStartState))completionHandler;
```

* If you do not choose to utilize the `Info.plist` file to define the **Blesh Ads Platform Access Key**, you may optionally pass it using the `withSecretKey` parameter.

* `withApplicationUser` parameter allows you to enchance the audience data by providing information about the primary user (subscriber) of your application. You can give any information which makes the subscriber unique in your application's understanding. The `BleshSdkApplicationUser` class contains the following:

| Description                                    | Swift Property                         | Objective-C Property                          | Example                   |
|------------------------------------------------|----------------------------------------|-----------------------------------------------|---------------------------|
| Optional unique identifier of the user         | userId: String?                        | (NSString *)userId                            | 42                        |
| Optional gender of the user (.female or .male) | gender: BleshSdkApplicationUserGender? | (NSNumber *)genderCode                        | .female (Swift) 0 (Obj-c) |
| Optional year of birth of the user             | yearOfBirth: Int?                      | (NSNumber *)yearOfBirth                       | 1999                      |
| Optional email address of the user             | email: String?                         | (NSString *)email                             | jane.doe@example.com      |
| Optional mobile phone number of the user       | phoneNumber: String?                   | (NSString *)phoneNumber                       | +905550000000             |
| Optional extra information for the user        | other: Dictionary<String,String>?      | (NSDictionary<NSString *, NSString *> *)other |                           |

> **Note:** `email` and `phoneNumber` details are never sent in plain-text to the *Blesh Ads Platform*. These values are always irreversibly hashed so that no personally identifiable information is stored.

* `withConfiguration` parameter allows you to configure the behaviour of the Blesh iOS SDK. The `BleshSdkConfiguration` class contains the following:

| Property              | Type   | Description                                                                       | Example                          |
|-----------------------|--------|-----------------------------------------------------------------------------------|----------------------------------|
| testMode              | Bool   | Use the SDK in the test mode (true) or use the SDK in the production mode (false) | false                            |
| pushNotificationToken | String | Remote push notification token (device registration token)                        | `Messaging.messaging().fcmToken` |

For valid values of `pushNotificationToken` please refer to the [FCM iOS Documentation](https://firebase.google.com/docs/cloud-messaging/ios/client#fetching-the-current-registration-token) for more information.

> **Note:** `testMode` is off by default. You can enable this mode during your integration tests. Production environment will not be effected when this flag is set to `true`.

* `completionHandler` parameter allows you to execute your business logic after the Blesh iOS SDK initialization is succeeded or failed.

##### Example: Simple Initialization (Singleton)

You can start the Blesh iOS SDK by simply invoking the `start` method of the shared instance:

**Swift:**

```swift
BleshSdk.sharedInstance.start()
```

**Objective-C:**

```objective-c
[[BleshSdk sharedInstance] start];
```

##### Example: Simple Initialization

You can start the Blesh iOS SDK by simply invoking the `start` method of the instance:

**Swift:**

```swift
let bleshSdk = BleshSdk()

bleshSdk.start()
```

**Objective-C:**

```objective-c
BleshSdk* bleshSdk = [[BleshSdk alloc] init];
[bleshSdk start];
```

##### Example: Complete Initialization

**Swift:**

```swift
let bleshSdkConfiguration = BleshSdkConfiguration(
	testMode: false,
	pushNotificationToken: Messaging.messaging().fcmToken ?? BleshSdk.sharedInstance.pushNotificationToken
)

let bleshSdkApplicationUser = BleshSdkApplicationUser(
	userId: "42",
	gender: .female,
	yearOfBirth: 1999,
	email: "jane.doe@example.com",
	phoneNumber: "+905550000000",
	other: nil
)

BleshSdk.sharedInstance.start(
	withApplicationUser: bleshSdkApplicationUser,
	withConfiguration: bleshSdkConfiguration) {
		(sdkState) -> () in
		// ... INSERT BUSINESS LOGIC HERE ...
		NSLog("BleshSDK start completed: " + sdkState.description)
	}
```

**Objective-C:**

```objective-c
BleshSdkConfiguration *configuration = [[BleshSdkConfiguration alloc]
                                        initWithTestMode:false
                                        adsEnabled:true
                                        pushNotificationToken:[FIRMessaging messaging].FCMToken ?: [BleshSdk sharedInstance].pushNotificationToken];

BleshSdkApplicationUser *user = [[BleshSdkApplicationUser alloc] initWithUserId:@"42"
                                      genderCode:0 // 0: female 1: male
                                      yearOfBirth:@1999
                                      email:@"jane.doe@example.com"
                                      phoneNumber:@"+905550000000"
                                      other:nil];

[[BleshSdk sharedInstance] startWithApplicationUser:user
                                  withConfiguration:configuration
                                  completionHandler:^(enum BleshSdkStartState state) {
    // ... INSERT BUSINESS LOGIC HERE ...
    if (state == BleshSdkStartStateFailure) {
        NSLog(@"BleshSDK start completed: failure");
    } else if (state == BleshSdkStartStateSkipped) {
        NSLog(@"BleshSDK start completed: skipped");
    } else {
        NSLog(@"BleshSDK start completed: success");
    }
}];

```

### 3. Notifying the Blesh iOS SDK About Changes in Permissions

Starting from Blesh iOS SDK 4.0.7, the SDK does not ask the user for permissions. Your application needs to ask location permissions. See "[Reviewing Permissions](#3-reviewing-permissions)" section for more information.

When the location permission changes, your application should call the `didChangeLocationAuthorization` method of `BleshSdk` with the new status.

**Example:** Swift

```swift
import UIKit
import BleshSDK
import CoreLocation

class MyViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager

    required init?(coder aDecoder: NSCoder) {
        self.locationManager = CLLocationManager()

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 10
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestLocation()

        // ... rest of the method ...
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Notify the Blesh iOS SDK about the change here
        BleshSdk.sharedInstance.didChangeLocationAuthorization(status)
    }

    // ... rest of the controller ...
}
```

**Example:** Objective-C (ViewController.h)

```objective-c
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <BleshSDK/BleshSDK.h>
// ... rest of imports ...

@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

// ... rest of the interface ...

@end
```

**Example:** Objective-C (ViewController.m)

```objective-c
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    locationManager.distanceFilter = 10;
    [locationManager requestAlwaysAuthorization];
    [locationManager requestLocation];

    // ... rest of the method ...
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    // Notify the Blesh iOS SDK about the change here
    [[BleshSdk sharedInstance] didChangeLocationAuthorization:status];

    // ... rest of the method ...
}

// ... rest of the class ...

@end
```

### 4. Implementing the Blesh iOS SDK Delegate

Blesh iOS SDK allows you to decide whether or not to display an ad. Following optional methods are provided by the `BleshSdkDelegate` protocol:

```swift
optional func bleshSdk(_ sdk: BleshSdk, didCompleteStartWith state: BleshSdkStartState)
optional func bleshSdk(_ sdk: BleshSdk, willDisplayNotification notificationId: String) -> Bool
```

**Example:** Swift

```swift
import UIKit
import BleshSDK

class MyViewController: UIViewController, BleshSdkDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Mark this controller as the delegate of Blesh SDK
        BleshSdk.sharedInstance.delegate = self

        // ... rest of the method ...
    }


    func bleshSdk(_ sdk: BleshSdk, willDisplayNotification notificationId: String) -> Bool {
        NSLog("BleshSDK will display the notification with id: \(notificationId)")
        return true // allow BleshSDK to display this notification
    }

    // ... rest of the controller ...
}
```

### 5. Supporting Images with Remote Push Notifications

To enable the presentation of images through remote push notifications, Apple mandates the inclusion of media in the notification by utilizing a [Notification Service Extension](https://developer.apple.com/documentation/usernotifications/modifying_content_in_newly_delivered_notifications/).

Blesh iOS SDK supports downloading media attachments via the `decorateRemoteNotification` function.

An example Notification Service Extension can be like the following:

**Example:** Swift

```swift
import UserNotifications
import BleshSDK

class NotificationService: UNNotificationServiceExtension {
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        if let bestAttemptContent = bestAttemptContent {
            // Download and attach images
            BleshSdk.sharedInstance.decorateRemoteNotification(request, bestAttemptContent: bestAttemptContent)

            contentHandler(bestAttemptContent)
        }
    }

    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
```