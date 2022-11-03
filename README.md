# SportBuddy-iOS
SportBuddy iOS client app

[![Building](https://github.com/stateman92/MSc-SportBuddy-iOS/actions/workflows/main.yml/badge.svg)](https://github.com/stateman92/MSc-SportBuddy-iOS/actions/workflows/main.yml)

[MLKit](https://developers.google.com/ml-kit/vision/pose-detection/ios)

## Issues

[SwiftyOnboard issue #57](https://github.com/juanpablofernandez/SwiftyOnboard/issues/57)

[SPM package with an embedded pod 1](https://stackoverflow.com/questions/68314198/publish-swift-package-with-cocoapod-dependencies)

[SPM package with an embedded pod 2](https://stackoverflow.com/questions/69272311/swift-xcframework-with-cocoapod-embed-googlemap-build-successfully-but-on-usa)

[SPM package with an embedded pod 3](https://stackoverflow.com/questions/68548647/xcframework-with-pod-dependencies)

[Swift dependency visualizer Xcode 13+ issue](https://github.com/PaulTaykalo/objc-dependency-visualizer/issues/68#issuecomment-1100749090)

Do not try to reach localhost (127.0.0.1) from a real device (when you build the mac app locally).

## Setup

- Checkout repo

- Make sure you've installed Xcode 14.0.0 (Swift 5.7)

- Run `pod install` in the terminal in the SportBuddy directory

- Open SportBuddy.xcworkspace and hit run

### Helpers

#### Update licences

- Make sure you've installed [LicensePlist](https://github.com/mono0926/LicensePlist) - if not, use e.g. `brew install mono0926/license-plist/license-plist` via [Homebrew](https://brew.sh/)

- Run `license-plist` in the terminal in the SportBuddy directory

- Copy the results (com.mono0926.LicensePlist.Output/com.mono0926.LicensePlist/ and com.mono0926.LicensePlist.Output/com.mono0926.LicensePlist.plist) to the SportBuddy/Settings.bundle folder (rewrite the old versions)

#### Update mocks

- Make sure you've installed [Sourcery](https://github.com/krzysztofzablocki/Sourcery) - if not, use e.g. `brew install sourcery` via [Homebrew](https://brew.sh/)

- Run `sh sourcery.sh` in the terminal in the SportBuddy directory

- Copy (reference) the results (SportBuddy/SportBuddyTests/Generated/) to the SportBuddy/SportBuddyTests/Generated/ folder (rewrite the old versions in Xcode)

#### Update openapi generated files

- Make sure you've installed [OpenAPI generator](https://github.com/OpenAPITools/openapi-generator) 6.2.1 - if not, use e.g. `brew install openapi-generator` via [Homebrew](https://brew.sh/)

- Run `openapi-generator generate -i /path/to/descriptor/swagger.yaml -g swift5 --additional-properties=responseAs=AsyncAwait -o /path/to/output` in the terminal

#### Generate openapi generated files on all platforms

- Make sure you've installed [OpenAPI generator](https://github.com/OpenAPITools/openapi-generator) 6.2.1 - if not, use e.g. `brew install openapi-generator` via [Homebrew](https://brew.sh/)

- Make sure you've downloaded [Vapor server codegen](https://github.com/thecheatah/vapor-server-codegen) [this commit, 4.0.0](https://github.com/thecheatah/vapor-server-codegen/commit/59f6a580ac618782d1c51a0a4ded8fa1779e6de7) - if not, download it via [Download link](https://github.com/thecheatah/vapor-server-codegen/archive/refs/heads/4.zip)

- Run `sh openapi.sh` in the terminal in the root directory

#### Update version

- Run `sh bump.sh` in the terminal

- By default it bumps the patch version. If you want other behavior, add a `major` / `minor` / `patch` flag, e.g. `sh bump.sh major`

#### Visualize the dependencies between classes ([Issue](https://github.com/PaulTaykalo/objc-dependency-visualizer/issues/68#issuecomment-1113864431) with Xcode 13.0+)

- Clone Objective-C And Swift Dependencies Visualizer - use e.g. `git clone https://github.com/PaulTaykalo/objc-dependency-visualizer.git` in the terminal (you can change directory before this step: `cd /Users/<yourName>/Downloads`)

- Change directory to the cloned repo - use e.g. `cd objc-dependency-visualizer`

- Create the visualization - use e.g. `./generate-objc-dependencies-to-json.rb -d -p/Users/<myName>/Library/Developer/Xcode/DerivedData/<myProject>-randomcharacters/Build/Intermediates.noindex/<myProject>.build/<schemeName>-<targetName>/<myProject>.build/Objects-normal/x86_64 > origin.js`

- See the results - use e.g. `open index.html`

- Or use it as a one-liner: `cd /Users/<yourName>/Downloads ; git clone https://github.com/PaulTaykalo/objc-dependency-visualizer.git ; cd objc-dependency-visualizer ; ./generate-objc-dependencies-to-json.rb -d -p/Users/<myName>/Library/Developer/Xcode/DerivedData/<myProject>-randomcharacters/Build/Intermediates.noindex/<myProject>.build/<schemeName>-<targetName>/<myProject>.build/Objects-normal/x86_64 > origin.js ; open index.html`
