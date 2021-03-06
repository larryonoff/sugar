// swift-tools-version:5.6

import PackageDescription

let package = Package(
  name: "sugar",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v14),
    .macOS(.v11)
  ],
  products: [
    .library(name: .Client.analytics, targets: [.Client.analytics]),
    .library(name: .appVersion, targets: [.appVersion]),
    .library(name: "ComposableArchitectureExt", targets: ["ComposableArchitectureExt"]),
    .library(name: .concurrencyExt, targets: [.concurrencyExt]),
    .library(name: "FeedbackGenerator", targets: ["FeedbackGenerator"]),
    .library(name: "FoundationExt", targets: ["FoundationExt"]),
    .library(name: "GraphicsExt", targets: ["GraphicsExt"]),
    .library(name: "LoggerExt", targets: ["LoggerExt"]),
    .library(name: "OpenURL", targets: ["OpenURL"]),
    .library(name: .sfSymbol, targets: [.sfSymbol]),
    .library(name: .Client.store, targets: [.Client.store]),
    .library(name: "SwiftUIExt", targets: ["SwiftUIExt"]),
    .library(name: "UIKitExt", targets: ["UIKitExt"]),
    .library(name: .videoPlayer, targets: [.videoPlayer]),
    .library(name: .Client.userSettings, targets: [.Client.userSettings]),
    .library(name: .Client.userTracking, targets: [.Client.userTracking])
  ],
  dependencies: [
    .package(
      url: "https://github.com/adaptyteam/AdaptySDK-iOS",
      from: "1.17.7"
    ),
    .package(
      url: "https://github.com/amplitude/Amplitude-iOS",
      from: "8.10.2"
    ),
    .package(
      url: "https://github.com/JohnSundell/AsyncCompatibilityKit",
      from: "0.1.2"
    ),
    .package(
      url: "https://github.com/facebook/facebook-ios-sdk",
      from: "14.1.0"
    ),
    .package(
      url: "https://github.com/firebase/firebase-ios-sdk",
      from: "9.2.0"
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      branch: "concurrency-beta"
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-tagged",
      from: "0.7.0"
    )
  ],
  targets: [
    .target(
      name: .Client.analytics,
      dependencies: [
        "FoundationExt",
        .External.amplitude,
        .External.composableArchitecture,
        .External.Facebook.core,
        .External.Firebase.analytics,
        .External.tagged
      ]
    ),
    .target(name: .appVersion),
    .target(
      name: "ComposableArchitectureExt",
      dependencies: [
        .External.composableArchitecture
      ]
    ),
    .target(
      name: .concurrencyExt,
      linkerSettings: [
        .linkedFramework("Combine")
      ]
    ),
    .target(name: "FeedbackGenerator"),
    .target(name: "FoundationExt"),
    .target(name: "GraphicsExt"),
    .target(
      name: "LoggerExt",
      linkerSettings: [
        .linkedFramework("OSLog")
      ]
    ),
    .target(name: "OpenURL"),
    .target(name: .sfSymbol),
    .target(
      name: .Client.store,
      dependencies: [
        "AsyncCompatibilityKit",
        "FoundationExt",
        .Client.analytics,
        .External.adapty,
        .External.composableArchitecture,
        .External.tagged
      ],
      linkerSettings: [
        .linkedFramework("Combine"),
        .linkedFramework("StoreKit")
      ]
    ),
    .target(
      name: "SwiftUIExt",
      dependencies: [
        "GraphicsExt"
      ]
    ),
    .target(name: "UIKitExt"),
    .target(
      name: .Client.userSettings,
      dependencies: [
        .External.composableArchitecture
      ]
    ),
    .target(
      name: .videoPlayer,
      linkerSettings: [
        .linkedFramework("AVKit")
      ]
    ),
    .target(
      name: .Client.userTracking,
      dependencies: [
        .Client.analytics,
        .External.composableArchitecture,
        .External.Facebook.core
      ],
      linkerSettings: [
        .linkedFramework("AppTrackingTransparency")
      ]
    )
  ]
)

extension Target.Dependency {
  static let appVersion = byName(name: .appVersion)
  static let concurrencyExt = byName(name: .concurrencyExt)
  static let sfSymbol = byName(name: .sfSymbol)
  static let videoPlayer = byName(name: .videoPlayer)

  enum Client {
    static let analytics = byName(name: .Client.analytics)
    static let appStore = byName(name: .Client.store)
    static let userSettings = byName(name: .Client.userSettings)
    static let userTracking = byName(name: .Client.userTracking)
  }

  enum External {
    static let adapty = product(
      name: "Adapty",
      package: "AdaptySDK-iOS"
    )

    static let amplitude = product(
      name: "Amplitude",
      package: "Amplitude-iOS"
    )

    static let composableArchitecture = product(
      name: "ComposableArchitecture",
      package: "swift-composable-architecture"
    )

    enum Facebook {
      static let core = product(
        name: "FacebookCore",
        package: "facebook-ios-sdk"
      )
    }

    enum Firebase {
      static let analytics = product(
        name: "FirebaseAnalytics",
        package: "firebase-ios-sdk"
      )

      static let crashlytics = product(
        name: "FirebaseCrashlytics",
        package: "firebase-ios-sdk"
      )
    }

    static let tagged = product(
      name: "Tagged",
      package: "swift-tagged"
    )
  }
}

extension String {
  static let appVersion = "AppVersion"
  static let concurrencyExt = "ConcurrencyExt"
  static let sfSymbol = "SFSymbol"
  static let videoPlayer = "VideoPlayer"

  enum Client {
    static let analytics = "Analytics"
    static let store = "StoreClient"
    static let userSettings = "UserSettings"
    static let userTracking = "UserTracking"
  }
}
