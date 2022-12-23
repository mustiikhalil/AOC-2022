// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AOC-2022",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .executable(name: "runner", targets: ["runner"]),
    .library(
      name: "core",
      targets: ["core"]),
    .library(
      name: "aoc2022",
      targets: ["aoc2022"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.4"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .executableTarget(
      name: "runner",
      dependencies: [
        "aoc2022",
        .product(name: "ArgumentParser", package: "swift-argument-parser")]),
    .target(
      name: "aoc2022",
      dependencies: ["core"]),
    .target(
      name: "core",
      dependencies: []),
  ]
)
