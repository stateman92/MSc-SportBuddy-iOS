# SportBuddy-iOS
SportBuddy iOS client app

[MLKit](https://developers.google.com/ml-kit/vision/pose-detection/ios)

## Issues

[SwiftyOnboard issue #57](https://github.com/juanpablofernandez/SwiftyOnboard/issues/57)

[SPM package with an embedded pod 1](https://stackoverflow.com/questions/68314198/publish-swift-package-with-cocoapod-dependencies)

[SPM package with an embedded pod 2](https://stackoverflow.com/questions/69272311/swift-xcframework-with-cocoapod-embed-googlemap-build-successfully-but-on-usa)

[SPM package with an embedded pod 3](https://stackoverflow.com/questions/68548647/xcframework-with-pod-dependencies)

## Setup

- Checkout repo

- Make sure you've installed Xcode in the range 13.1-13.3

- Run `pod install` in the terminal in the SportBuddy directory

- Open SportBuddy.xcworkspace and hit run

### Helpers

#### Update licences

- Make sure you've installed [LicensePlist](https://github.com/mono0926/LicensePlist) - if not, use e.g. `brew install mono0926/license-plist/license-plist via [Homebrew](https://brew.sh/)
`

- Run `license-plist` in the terminal in the SportBuddy directory

- Copy the results (com.mono0926.LicensePlist.Output/com.mono0926.LicensePlist/ and com.mono0926.LicensePlist.Output/com.mono0926.LicensePlist.plist) to the SportBuddy/Settings.bundle folder (rewrite the old versions)

#### Update mocks

- Make sure you've installed [Sourcery](https://github.com/krzysztofzablocki/Sourcery) - if not use, e.g. `brew install sourcery` via [Homebrew](https://brew.sh/)

- Run `sh sourcery.sh` in the terminal in the SportBuddy directory

- Copy (reference) the results (SportBuddy/SportBuddyTests/Generated/) to the SportBuddy/SportBuddyTests/Generated/ folder (rewrite the old versions in Xcode)

#### Update openapi generated files

- Make sure you've installed [OpenAPI generator](https://github.com/OpenAPITools/openapi-generator) - if not use, e.g. `brew install openapi-generator` via [Homebrew](https://brew.sh/)

- Run `openapi-generator generate -i /path/to/descriptor/swagger.yaml -g swift5 --additional-properties=responseAs=AsyncAwait -o /path/to/output` in the terminal
