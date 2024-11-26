# SwiftUI Back4App Apple Sign-In

## Overview
This project demonstrates how to integrate **Apple Sign-In** with **Back4App** using the **ParseSwift SDK** in a **SwiftUI** application. The project handles user authentication, profile management, and logout functionality with a clean MVVM architecture.

---

## Requirements
Before using this project, ensure you have the following:

1. **Apple Developer Account**
   - You'll need an active Apple Developer account to enable Apple Sign-In.
   - Configure your **App ID** and enable **Sign In with Apple** in the Apple Developer portal.

2. **Back4App Account**
   - Sign up for a free account at [Back4App](https://www.back4app.com).
   - Follow the **[Back4App Quickstart Guide](https://www.back4app.com/docs/get-started/welcome)** to set up your application.
   - Obtain the **Application ID** and **Client Key** from your Back4App dashboard.

---

## Setup Instructions

### 1. Clone the Repository
```bash
git clone <repository-url>
cd <repository-folder>
```

### 2. Install the ParseSwift SDK
Choose one of the following methods to install the ParseSwift SDK:

#### a) Using Xcode Package Manager
1. Open your project in Xcode.
2. Go to **File > Add Package Dependencies**.
3. Enter the following URL in the search bar:  
   `https://github.com/parse-community/Parse-Swift`
4. Select the latest version and add it to your project
5. Select name of your project from a dropdown (if not selected)
6. Click **Add Package**
7. When prompted, select the target.

#### b) Using CocoaPods
1. Add the following line to your `Podfile`:
   ```ruby
   pod 'Parse-Swift'
   ```
2. Run `pod install` in the terminal to install the dependency.

For more details, see the official **[ParseSwift SDK Installation Guide](https://www.back4app.com/docs/ios/parse-swift-sdk/install-sdk)**.

---

### 3. Configure Back4App
- Log in to your Back4App account and create a new application.
- In the **App Settings**, find your **Application ID** and **Client Key**.

### 4. Configure Apple Sign-In
1. Go to the [Apple Developer Portal](https://developer.apple.com).
2. Create an **App ID** and enable **Sign In with Apple**:
   - Add the **Bundle Identifier** for your app.
   - Under **Capabilities**, enable "Sign In with Apple".

### 5. Update `App.swift`
Replace the placeholders in `App.swift` with your Back4App credentials:
```swift
ParseSwift.initialize(applicationId: "YOUR_APP_ID",
                      clientKey: "YOUR_CLIENT_KEY",
                      serverURL: URL(string: "https://parseapi.back4app.com/")!)
```

### 6. Run the Project
Open the project in Xcode, select your development team, and build/run the app on a simulator or physical device.

---

## Features
- **Apple Sign-In**: Authenticate users with their Apple ID.
- **Back4App Integration**: Save user information to Back4App's Parse database.
- **MVVM Architecture**: Clean separation of views and business logic.
- **Profile Management**: Display user information (email, name) and logout functionality.

---

## Contributing
Contributions are welcome! Feel free to fork this repository and submit pull requests.

---

## License
This project is licensed under the [MIT License](LICENSE).
