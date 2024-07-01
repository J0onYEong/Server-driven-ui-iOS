import ProjectDescription

let baseBundleId = "com.swm-ios.sdu"
let deploymentTarget = DeploymentTargets.iOS("17.0")

let project = Project(
    name: "SDU-iOS",
    targets: [
        
        // MARK: App
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: baseBundleId,
            deploymentTargets: deploymentTarget,
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": [
                            "UIWindowSceneSessionRoleApplication": [
                                [
                                    "UISceneConfigurationName": "Default Configuration",
                                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                                ]
                            ]
                        ]
                    ]
                ]
            ),
            sources: ["Project/App/Sources/**"],
            resources: ["Project/App/Resources/**"],
            dependencies: [
                .target(name: "Presentation"),
                .target(name: "Domain"),
                .target(name: "Data"),
            ]
        ),
        
        // MARK: Presentation
        .target(
            name: "Presentation",
            destinations: .iOS,
            product: .framework,
            bundleId: "\(baseBundleId).presentation",
            deploymentTargets: deploymentTarget,
            sources: ["Project/Presentation/Sources/**"],
            resources: ["Project/Presentation/Resources/**"],
            dependencies: [
                .target(name: "Domain"),
                .target(name: "Data"),
                .external(name: "RxSwift"),
                .external(name: "RxCocoa"),
                .external(name: "RxRelay"),
            ]
        ),
        
        // MARK: Domain
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: "\(baseBundleId).domain",
            deploymentTargets: deploymentTarget,
            sources: ["Project/Domain/**"],
            dependencies: []
        ),
        
        
        // MARK: Data
        .target(
            name: "Data",
            destinations: .iOS,
            product: .framework,
            bundleId: "\(baseBundleId).data",
            deploymentTargets: deploymentTarget,
            sources: ["Project/Data/**"],
            dependencies: [
                .target(name: "Domain"),
                .external(name: "Alamofire"),
            ]
        ),
        
        // MARK: Tests
        .target(
            name: "ProjectTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(baseBundleId).tests",
            infoPlist: .default,
            sources: ["Project/Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "App"),
                .target(name: "Presentation"),
                .target(name: "Domain"),
                .target(name: "Data"),
            ]
        ),
    ]
)
