// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ShadcnSwift",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [.library(name: "ShadcnSwift", targets: ["ShadcnSwift"])],
    targets: [.target(name: "ShadcnSwift")]
)
