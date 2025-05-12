# Specialty Coffee iOS App

This project is an iOS application built using the MVVM-C architecture with SwiftUI and Combine. It is designed to consume APIs from the Specialty Coffee backend server.

## Project Structure

```
SpecialtyCoffeeApp/
├── App/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── AppCoordinator.swift
│   ├── AppEnvironment.swift
├── Features/
│   ├── Authentication/
│   ├── Orders/
│   ├── Shops/
│   ├── Roasters/
│   ├── Prices/
├── Networking/
│   ├── APIClient.swift
│   ├── Endpoints.swift
├── Utilities/
│   ├── Extensions/
│   ├── Helpers/
├── Resources/
│   ├── Assets.xcassets
│   ├── Localizable.strings
│   ├── Info.plist
├── Tests/
│   ├── UnitTests/
│   ├── UITests/
```

## Features
- Authentication
- Orders Management
- Shops Management
- Roasters Management
- Prices Management

## Getting Started
1. Clone the repository.
2. Open the project in Xcode.
3. Build and run the app.

## Requirements
- Xcode 14 or later
- iOS 15.0 or later

## License
This project is licensed under the MIT License.