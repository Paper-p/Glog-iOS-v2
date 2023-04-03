import ProjectDescription

extension Project{
    public static func executable(
        name: String,
        platform: Platform,
        packages: [Package] = [],
        product: Product = .app,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "16.0", devices: [.iphone,.iphone]),
        dependencies: [TargetDependency]
    ) -> Project {
        return Project(
            name: name,
            organizationName: publicOrganizationName,
            packages: packages,
            targets: [
                Target(
                    name: name,
                    platform: platform,
                    product: product,
                    bundleId: "\(publicOrganizationName).\(name)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .file(path: Path("Targets/MyApp/Support/Info.plist")),
                    sources: ["Targets/MyApp/Sources/**"],
                    resources: ["Targets/MyApp/Resources/**"],
                    entitlements: Path("Targets/MyApp/Support/\(name).entitlements"),
                    dependencies: dependencies
                )
            ]
        )
    }
}
