import PackageDescription

let package = Package(
    name: "TTT",
    dependencies: [
        .Package(url: "https://github.com/zhangyuhan0407/OCTJSON", majorVersion: 1)
    ]
)
