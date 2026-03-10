# emi_locker_plugin

A Flutter plugin designed to lock and secure Android devices. It leverages Android `DevicePolicyManager` to restrict user actions, disable the status bar, and enter kiosk mode. 

## Use Case / Purpose

This plugin is useful for:
- **EMI Device Financing Apps**: Secure financed devices and ensure EMI compliance.
- **Anti-Theft Security**: Remotely lock a phone if it is lost or stolen to protect personal data and render the device unusable to unauthorized users.

**Example scenario (EMI Financing):**

1. A user buys a mobile phone on EMI.
2. The financing app installs this EMI locker app.
3. If the user misses EMI payment, the device automatically locks.
4. Once the user pays the EMI, the app verifies payment through the API and unlocks the device.

This system helps finance companies secure financed devices and ensure EMI compliance.

## Features

- **Lock Device**: Secures the device, pins the app, disables the status bar, and hides settings. Prevents safe boot, app installation/uninstallation, and factory reset.
- **Unlock Device**: Removes the restrictions and restores normal device operation.
- **EMI Status Check**: Includes a service (`EmiService`) to verify payment status before unlocking.

## Platform Support

- Android (requires Device Owner privileges)

## Setup

For this plugin to work, the app using it MUST be set as the **Device Owner** on the Android device.

> [!IMPORTANT]
> To use this feature, you must **Factory Reset** the phone first.

There are two methods to set your app as the Device Owner:

### Method 1: ADB Command
After installing the app, run the following command via ADB:

```bash
adb shell dpm set-device-owner your.application.id/com.emi.locker.MyDeviceAdminReceiver
```
*(Replace `your.application.id` with your actual app package name)*

---

### Method 2: QR Code Provisioning
This method is recommended for bulk deployment or when ADB is not available.

**Step-by-Step Instructions:**
1. **Factory Reset** the phone.
2. When you see the **"Welcome / Select Language"** screen, **tap the screen 6 times** in the same spot.
3. The Android Enterprise **QR Scanner** will open.
4. Scan a QR code generated from the following JSON payload:

```json
{
  "android.app.extra.PROVISIONING_DEVICE_ADMIN_COMPONENT_NAME": "com.emi.locker/.MyDeviceAdminReceiver",
  "android.app.extra.PROVISIONING_DEVICE_ADMIN_PACKAGE_DOWNLOAD_LOCATION": "https://github.com/Amarj234/flutter_learn_advance/releases/download/apkupload/emi-locker.apk",
  "android.app.extra.PROVISIONING_DEVICE_ADMIN_PACKAGE_CHECKSUM": "BASE64_SHA256_HERE",
  "android.app.extra.PROVISIONING_SKIP_ENCRYPTION": true
}
```

> [!NOTE]  
> Ensure the `PROVISIONING_DEVICE_ADMIN_PACKAGE_DOWNLOAD_LOCATION` points to your actual APK and `PROVISIONING_DEVICE_ADMIN_PACKAGE_CHECKSUM` is the BASE64 SHA256 of your APK.

## Usage

Add the plugin to your `pubspec.yaml` dependencies:
```yaml
dependencies:
  emi_locker_plugin:
    path: path/to/emi_locker_plugin
```

Import the package in your dart files:
```dart
import 'package:emi_locker_plugin/emi_locker_plugin.dart';
```

### Locking and Unlocking
```dart
// Lock the device
await DeviceControl.lockDevice();

// Unlock the device
await DeviceControl.unlockDevice();
```

### EmiLocker Widget
The plugin comes with a ready-to-use `EmiLocker` widget that acts as the main entry point to lock the screen.
```dart
MaterialApp(
  home: EmiLocker(),
);
```

## Author

Made by **AmarJeet Kushwaha**

Let's connect on [LinkedIn](https://www.linkedin.com/in/amarj234/)! 

## EMI Service

The plugin includes `EmiService` to check EMI payment status, useful for finance apps such as Bajaj Finance.

```dart
class EmiService {
  Future<bool> isEmiPaid() async {
    final response = await http.get(
      Uri.parse("https://api.example.com/emi-status"),
    );

    final data = jsonDecode(response.body);

    return data["emi_status"] == "paid";
  }
}
```

**Usage**

```dart
final emiService = EmiService();
bool paid = await emiService.isEmiPaid();
if (paid) {
  // proceed with unlocking or other logic
}
```

